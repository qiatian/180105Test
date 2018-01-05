//
//  LLQKeyChainTool.h
//  Accumulation
//
//  Created by sanjingrihua on 17/4/28.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLQKeyChainTool : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;
@end
