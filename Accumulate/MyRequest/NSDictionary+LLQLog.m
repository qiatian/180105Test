//
//  NSDictionary+LLQLog.m
//  Accumulation
//
//  Created by sanjingrihua on 16/11/30.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import "NSDictionary+LLQLog.h"

@implementation NSDictionary (LLQLog)
-(NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
 {
         //初始化可变字符串
         NSMutableString *string = [NSMutableString string];
        //拼接开头[
         [string appendString:@"["];
    
         //拼接字典中所有的键值对
         [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                 [string appendFormat:@"%@:",key];
                 [string appendFormat:@"%@",obj];
             }];
    
         //拼接结尾]
         [string appendString:@"]"];
     
         return string;
 }
@end
