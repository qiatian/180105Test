//
//  Person.h
//  Accumulation
//
//  Created by sanjingrihua on 17/5/27.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property(nonatomic,strong)NSString *name;
-(void)run:(NSNumber *)meter;
-(void)eat;
-(void)play;
-(void)test;
+(instancetype)modelWithDict:(NSDictionary *)dic;

//动态交换方法
- (void)firstMethod;
- (void)secondMethod;
@end
