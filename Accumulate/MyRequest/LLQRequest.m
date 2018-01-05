//
//  LLQRequest.m
//  Accumulation
//
//  Created by sanjingrihua on 16/11/30.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import "LLQRequest.h"
static id _instance;
@implementation LLQRequest
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized (self) {
        if (_instance==nil) {
            _instance=[super allocWithZone:zone];
        }
    }
    return _instance;
}
+(instancetype)sharedInstance
{
    @synchronized (self) {
        if (_instance==nil) {
            _instance=[[self alloc]init];
        }
    }
    return _instance;
}
-(id)copyWithZone:(NSZone*)zone
{
    return _instance;
}
+(void)requestGetWith:(NSDictionary *)dic
{
    //确定请求路径
    NSURL *url=[NSURL URLWithString:@"http://www.sanjingrihua.com"];
    
//    创建请求对象
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
//    获得会话对象
    NSURLSession *session= [NSURLSession sharedSession];
    
//    根据会话对象创建一个Task（发送请求）
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",data);
    }];
    
    [dataTask resume];//执行任务
    
}
+(void)requestPost
{
//    创建会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    
//    根据会话对象创建一个Task
    NSURL *url=[NSURL URLWithString:@"http://sanjingrihua.com"];
    
//    创建可变的请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod=@"POST";//修改请求方法
    request.HTTPBody=[@"username=322&pwd=455&type=Json" dataUsingEncoding:NSUTF8StringEncoding];//设置请求体

//    根据会话对象创建一个Task（发送请求）
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //8.解析数据
                 NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                 NSLog(@"%@",dict);
    }];
    
    [dataTask resume];//执行任务
    
}
@end
