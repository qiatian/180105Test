//
//  LQPlayer.m
//  Accumulate
//
//  Created by sanjingrihua on 2017/12/27.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "LQPlayer.h"
#import <AudioUnit/AudioUnit.h>
#import <AVFoundation/AVFoundation.h>

const uint32_t CONST_BUFFER_SIZE = 0x10000;
#define INPUT_BUS 1 //输入
#define OUTPUT_BUS 0 //输出
#define CONST_BUFFER_SIZE 2048*2*10
@implementation LQPlayer
{
    AudioUnit audioUnit;
    AudioBufferList *bufferList;//缓存列表
    NSInputStream *inputStream;//需要播放的文件流
    Byte *buffer;//录播一起时候 新增属性
}
-(void)play{
    //播放需要初始化一个Player
    [self initPlayer];
    //
    AudioOutputUnitStart(audioUnit);
}
-(void)stop{
    AudioOutputUnitStop(audioUnit);
    if (bufferList != NULL) {
        if (bufferList->mBuffers[0].mData) {
            free(bufferList->mBuffers[0].mData);
            bufferList->mBuffers[0].mData = NULL;
            
        }
        free(bufferList);
        bufferList = NULL;
    }
    
    //代理回调，让控制器控制停止按钮的操作
}
-(void)initPlayer{
    //Pcm文件 URL
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"abc" withExtension:@"pcm"];
    
    inputStream = [NSInputStream inputStreamWithURL:url];
    if (!inputStream) {
        NSLog(@"打开文件失败，初始化失败");
    }else{
        //打开文件流
        [inputStream open];
    }
    NSError *error = nil;
    OSStatus status = noErr;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //强制关闭其他应用正在播放的功能  AVAudioSessionCategoryPlayAndRecord边录边放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:&error];
    
    //录播一起时候 新增属性  设置硬件IO缓存持续时间0.05秒
    [audioSession setPreferredIOBufferDuration:0.05 error:&error];
    //给buffer开辟空间
    buffer = malloc(CONST_BUFFER_SIZE);
    
    AudioComponentDescription audioDesc;
    audioDesc.componentType = kAudioUnitType_Output;
    audioDesc.componentSubType = kAudioUnitSubType_RemoteIO;
    audioDesc.componentManufacturer = kAudioUnitManufacturer_Apple;
    audioDesc.componentFlags = 0;
    audioDesc.componentFlagsMask = 0;
    
    AudioComponent inputComment = AudioComponentFindNext(NULL, &audioDesc);
    AudioComponentInstanceNew(inputComment, &audioUnit);
    
    
    //缓存列表 初始化 开辟空间
    //只播
    bufferList = (AudioBufferList*)malloc(sizeof(AudioBufferList));
    bufferList->mNumberBuffers = 1;
    bufferList->mBuffers[0].mNumberChannels = 1;
    bufferList->mBuffers[0].mDataByteSize = INT32_MAX;//CONST_BUFFER_SIZE
    bufferList->mBuffers[0].mData = malloc(INT32_MAX);
    
    UInt32 flag = 1;
    status = AudioUnitSetProperty(audioUnit, kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Output, OUTPUT_BUS, &flag, sizeof(flag));
    
    if (status) {
        return;
    }
    
    //输出格式
    AudioStreamBasicDescription outPutFormat ;//= {0}清空等价下边
    memset(&outPutFormat, 0, sizeof(outPutFormat));
    outPutFormat.mSampleRate = 44100;//采样率
    outPutFormat.mFormatID = kAudioFormatLinearPCM;
    outPutFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger;//格式标记
    outPutFormat.mFramesPerPacket = 1;//包包含帧
    outPutFormat.mChannelsPerFrame = 1;//每帧包含通道
    outPutFormat.mBytesPerPacket = 2;//每包包含字节
    outPutFormat.mBytesPerFrame = 2;//每帧 包含字节
    outPutFormat.mBitsPerChannel = 16;
    
    [self printAudioStreamBasicDescription:outPutFormat];
    
    
    status = AudioUnitSetProperty(audioUnit, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Input, OUTPUT_BUS, &outPutFormat, sizeof(outPutFormat));
    if (status) {
        NSLog(@"AudioUnitSetProperty error");
        return;
    }
    
    //回调
    AURenderCallbackStruct playCallBack;
    playCallBack.inputProc = PlayCallback;//播放的回调
    playCallBack.inputProcRefCon = (__bridge void*)self;
    
    status = AudioUnitSetProperty(audioUnit, kAudioUnitProperty_SetRenderCallback, kAudioUnitScope_Input, OUTPUT_BUS, &playCallBack, sizeof(playCallBack));
    
    if (status) {
        NSLog(@"AudioUnitSetProperty error");
        return;
    }
    
    status = AudioUnitInitialize(audioUnit);
    if (status) {
        NSLog(@"AudioUnitInitialize error");
        return;
    }
    
}
static OSStatus
 PlayCallback(    void *                            inRefCon,
                    AudioUnitRenderActionFlags *    ioActionFlags,
                    const AudioTimeStamp *            inTimeStamp,
                    UInt32                            inBusNumber,
                    UInt32                            inNumberFrames,
                                 AudioBufferList * __nullable    ioData){
     
     LQPlayer *player = (__bridge LQPlayer*)inRefCon;
     ioData->mBuffers[0].mDataByteSize = (UInt32)[player->inputStream read:ioData->mBuffers[0].mData maxLength:ioData->mBuffers[0].mDataByteSize];
     
     NSLog(@"输出数据大小：%d",ioData->mBuffers[0].mDataByteSize);
     if (ioData->mBuffers[0].mDataByteSize<=0) {
         //没有数据，停止播放
         dispatch_async(dispatch_get_main_queue(), ^{
             [player stop];
         });
     }
     
     
     //左耳人声，右耳伴奏
     LQPlayer *player1 = (__bridge LQPlayer*)inRefCon;
     memcpy(ioData->mBuffers[0].mData, player1->bufferList->mBuffers[0].mData, player1->bufferList->mBuffers[0].mDataByteSize);
     //播放的数据
     ioData->mBuffers[0].mDataByteSize = player->bufferList->mBuffers[0].mDataByteSize;
     //伴奏结束 人声停止录制  保证人声跟伴奏对齐
     NSInteger bytes = CONST_BUFFER_SIZE < ioData->mBuffers[1].mDataByteSize*2? CONST_BUFFER_SIZE:ioData->mBuffers[1].mDataByteSize*2;
     //读出伴奏
     bytes = [player->inputStream read:player->buffer maxLength:bytes];
     //循环作对齐
     for (int i=0; i<bytes; i++) {
         ((Byte *)ioData->mBuffers[1].mData)[i/2] = player->buffer[i];
     }
     ioData->mBuffers[1].mDataByteSize = (UInt32)bytes/2;
     if (ioData->mBuffers[1].mDataByteSize<ioData->mBuffers[0].mDataByteSize) {
         ioData->mBuffers[1].mDataByteSize = ioData->mBuffers[0].mDataByteSize;
     }
     return noErr;
 }
-(void)bianlubianfang{
    OSStatus status = noErr;
    //边录边放
    UInt32 numberBuffers = 2;
    bufferList = (AudioBufferList*)malloc(sizeof(AudioBufferList)+(numberBuffers-1)*sizeof(AudioBuffer));
    bufferList->mNumberBuffers = numberBuffers;
    bufferList->mBuffers[0].mNumberChannels = 1;
    bufferList->mBuffers[0].mDataByteSize = INT32_MAX;
    bufferList->mBuffers[0].mData = malloc(INT32_MAX);
    for (int i = 1; i<numberBuffers; i++) {
        bufferList->mBuffers[i].mNumberChannels = 1;
        bufferList->mBuffers[i].mDataByteSize = INT32_MAX;
        bufferList->mBuffers[i].mData = malloc(INT32_MAX);
    }
    //设置输入输出格式
    AudioStreamBasicDescription inputFormat;
    inputFormat.mSampleRate = 44100;
    inputFormat.mFormatID = kAudioFormatLinearPCM;
    inputFormat.mFormatFlags = kAudioFormatFlagIsSignedInteger|kAudioFormatFlagIsNonInterleaved;
    inputFormat.mFramesPerPacket = 1;
    inputFormat.mChannelsPerFrame = 1;
    inputFormat.mBytesPerFrame =2;
    inputFormat.mBytesPerPacket = 2;
    inputFormat.mBitsPerChannel = 16;
    [self printAudioStreamBasicDescription:inputFormat];
    status = AudioUnitSetProperty(audioUnit, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Output,INPUT_BUS, &inputFormat, sizeof(inputFormat));
    if (status!=noErr) {
        NSLog(@"AudioUnitSetProperty error");
        return;
    }
    //设置输出格式
    AudioStreamBasicDescription outputFormat = inputFormat;
    outputFormat.mChannelsPerFrame = 2;
    status = AudioUnitSetProperty(audioUnit, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Input, OUTPUT_BUS, &outputFormat, sizeof(outputFormat));
    if (status!=noErr) {
        NSLog(@"AudioUnitSetProperty error");
        return;
    }
    //录制属性设置
    UInt32 flag = 1;
    status = AudioUnitSetProperty(audioUnit, kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Input, INPUT_BUS, &flag, sizeof(flag));//BUFFER_INPUT  BUFFER_OUTPUT BUFFER_INPUT
    
    if (status) {
        return;
    }
    //回调 播放 录制
    AURenderCallbackStruct playCallBack;
    playCallBack.inputProc = PlayCallback;//播放的回调
    playCallBack.inputProcRefCon = (__bridge void*)self;
    status = AudioUnitSetProperty(audioUnit, kAudioUnitProperty_SetRenderCallback, kAudioUnitScope_Input, OUTPUT_BUS, &playCallBack, sizeof(playCallBack));
    if (status!=noErr) {
        NSLog(@"AudioUnitSetProperty error");
        return;
    }
    
    //录制回调
    AURenderCallbackStruct recordCallBack;
    recordCallBack.inputProc = RecordCallBack;
    recordCallBack.inputProcRefCon = (__bridge void*)self;
    status = AudioUnitSetProperty(audioUnit, kAudioUnitProperty_SetRenderCallback, kAudioUnitScope_Output, INPUT_BUS, &recordCallBack, sizeof(recordCallBack));
    if (status!=noErr) {
        NSLog(@"AudioUnitSetProperty error");
        return;
    }
    //初始化
    status = AudioUnitInitialize(audioUnit);
    if (status) {
        NSLog(@"AudioUnitInitialize error");
        return;
    }
    
    
}
static OSStatus
RecordCallBack(    void *                            inRefCon,
             AudioUnitRenderActionFlags *    ioActionFlags,
             const AudioTimeStamp *            inTimeStamp,
             UInt32                            inBusNumber,
             UInt32                            inNumberFrames,
             AudioBufferList * __nullable    ioData){
    
    LQPlayer *player = (__bridge LQPlayer*)inRefCon;
    //录制声音
    player->bufferList->mNumberBuffers = 1;
    OSStatus status = AudioUnitRender(player->audioUnit, ioActionFlags, inTimeStamp, inBusNumber, inNumberFrames, player->bufferList);
    if (status!=noErr) {
        NSLog(@"AudioUnitRender  error");
        return -1;
    }
    [player writePCMData:player->bufferList->mBuffers[0].mData size:player->bufferList->mBuffers[0].mDataByteSize];
    return noErr;
}
-(void)writePCMData:(Byte *)buffer size:(int)size{
    static FILE *file = NULL;
    NSString *path = [NSTemporaryDirectory() stringByAppendingString:@"/record.pcm"];
    if (!file) {
        file = fopen(path.UTF8String, "W");
    }
    fwrite(buffer, size, 1, file);
}
-(void)printAudioStreamBasicDescription:(AudioStreamBasicDescription)desc{
    
}
@end
