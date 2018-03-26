//
//  LLQDownLoader.m
//  Accumulate
//
//  Created by sanjingrihua on 2018/1/12.
//  Copyright © 2018年 sanjingrihua. All rights reserved.
//

#import "LLQDownLoader.h"

@implementation LLQDownLoader
+(void)downLoader:(NSURL*)url{
    
    //文件存放
    //正在下载===temp+名称
    //MD5 + URL 防止重复资源
    //下载完成===cache+名称
    
    //判断URL地址，对应的资源 是否已经下载完毕
    //告诉外界下载完毕，并且传递相关信息（本地路径，文件大小）
    //检测，临时文件是否存在
    //不存在：从0字节开始请求资源
    //以当前的存在文件大小，作为开始字节，去网络请求资源
    //如果本地大小==总大小 ---移动到下载完成的路径中
    //本地大小>总大小----删除本地临时缓存，从0开始下载
    //本地大小<总大小 ---- 从本地大小开始下载
    
}
@end
