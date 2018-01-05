//
//  NSObject+Property.h
//  Accumulation
//
//  Created by sanjingrihua on 17/5/27.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Property)
//@property分类:只会生成get,set方法声明，不会生成实现，也不会生成下划线成员属性。
@property NSString *name;
@end
