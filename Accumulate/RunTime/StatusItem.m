//
//  StatusItem.m
//  Accumulation
//
//  Created by sanjingrihua on 17/5/27.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "StatusItem.h"

@implementation StatusItem

//KVC缺点：模型的属性和字典不能一一对应    ---runtime可以把一个模型中所有属性遍历出来
+(instancetype)itemWithDict:(NSDictionary*)dict
{
    StatusItem *item = [[self alloc]init];
    //KVC：把字典中所有值给模型属性赋值
//    [item setValuesForKeysWithDictionary:dict];
    
    
//    KVC原理：
//    //1.遍历字典中所有key，去模型中查找有哦没有对应的属性
//    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        //2.去模型中查找有没有对应属性KVC
//        [item setValue:obj forKey:key];
//    }];
//    
    return item;
}
//重写系统方法 1.想给系统方法添加额外方法 2.不想要系统方法报错
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
//[item setValue:@"来自即刻笔记" forKey:@"source"];1.首先去模型中查找有没有setSource，找到，直接赋值 self 2.去模型中查找有没有source属性，有，直接访问属性赋值source = value 2.去模型中查找有没有_source属性，有，直接访问属性赋值 _source = value

@end
