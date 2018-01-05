//
//  LLQScanViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 16/11/30.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import "LLQScanViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface LLQScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *session;
    AVCaptureVideoPreviewLayer *layer;
    UIView *lineView;
    
    NSTimer *timer;
}

@end

@implementation LLQScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addScanBtn];
}
-(void)addScanBtn
{
    UIButton *sBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sBtn.frame=CGRectMake(self.view.frame.size.width-100, 100, 80, 30);
    [sBtn setTitle:@"扫码" forState:UIControlStateNormal];
    [sBtn addTarget:self action:@selector(scanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sBtn];
}
#pragma mark-------scanBtnClick
-(void)scanBtnClick:(UIButton*)btn
{
    NSLog(@"Scan");
    //获取摄像设备
    AVCaptureDevice *device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //创建输入流
    AVCaptureDeviceInput *input=[AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    NSError *error=nil;
    if (input) {
        //设置会话的输入设备
        [session addInput:input];
    }else{
        NSLog(@"error-----%@",[error localizedDescription]);
    }
    //创建输出流
    AVCaptureMetadataOutput *output=[[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    [session addOutput:output];
    //设置扫码支持的编码格式
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
    layer=[AVCaptureVideoPreviewLayer layerWithSession:session];
    //设置相机扫描框大小
    layer.frame=CGRectMake(20, 150,280, 240);
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [session startRunning];
    lineView=[[UIView alloc]initWithFrame:CGRectMake(layer.frame.origin.x, layer.frame.origin.y, layer.frame.size.width, 1)];
    lineView.backgroundColor=[UIColor greenColor];
    [self.view addSubview:lineView];
    
    timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    
    [timer fire];
}
-(void)timerStart:(NSTimer*)tm
{
    [UIView animateWithDuration:1.0f animations:^{
        lineView.frame=CGRectMake(layer.frame.origin.x, layer.frame.origin.y+layer.frame.size.height-1, layer.frame.size.width, 1);
    } completion:^(BOOL finished) {
        lineView.frame=CGRectMake(layer.frame.origin.x, layer.frame.origin.y, layer.frame.size.width, 1);
    }];
}
#pragma mark-------AVCaptureMetadataOutputObjectsDelegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSLog(@"扫描结果");
    lineView.hidden=YES;
    [timer invalidate];

    NSString *lQRCode=nil;
    for (AVMetadataObject *metadata in metadataObjects) {
        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            lQRCode=[(AVMetadataMachineReadableCodeObject*)metadata stringValue];
            break;
        }
    }
    NSLog(@"%@",lQRCode);
    [session stopRunning];//结束捕获
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
