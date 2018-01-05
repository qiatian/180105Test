//
//  NSObject+Property.m
//  Accumulation
//
//  Created by sanjingrihua on 17/5/27.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/message.h>
@implementation NSObject (Property)
static NSString *_name;
-(void)setName:(NSString *)name
{
//    _name = name;
    //让这个字符串与当前对象产生联系
    //object：给哪个对象添加属性  key：属性名称 value:属性值  policy：保存策略
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSString*)name
{
//    return _name;
    return objc_getAssociatedObject(self, @"name");
}
@end
