//
//  NSObject+Model.h
//  Accumulation
//
//  Created by sanjingrihua on 17/5/27.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import <Foundation/Foundation.h>
//字典转模型
@interface NSObject (Model)
+(instancetype)modelWithDict:(NSDictionary*)dict;
@end
