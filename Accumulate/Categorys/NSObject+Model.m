//
//  NSObject+Model.m
//  Accumulation
//
//  Created by sanjingrihua on 17/5/27.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/message.h>
#import "Person.h"
@implementation NSObject (Model)
//class_copyMethodList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)获取类里面所有方法
+(instancetype)modelWithDict:(NSDictionary*)dict
{
    id objc = [[self alloc]init];
    
    //runtime:根据模型中属性，去字典中取出对应的value给模型赋值
//    1.获取模型中所有成员变量 Ivar成员变量(_name) property属性 count成员变量个数
    int count = 0;
    Ivar *ivarList = class_copyIvarList(self, &count);
    
//    遍历所有成员变量
    for (int i=0; i<count; i++) {
        Ivar  ivar = ivarList[i];
        //获取成员变量名字
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //获取成员变量类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        //@\"User"\->User
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        //获取key
        NSString *key = [ivarName substringFromIndex:1];
        //去字典中查找对应的value
        id value = dict[key];
//        二级转换：判断value是否是字典，如果是，字典转换成对应的模型
        //并且是自定义对象才需要转换
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            
            
            //获取类
            Class modelClass = NSClassFromString(ivarType);
            
            value = [modelClass modelWithDict:value];
        }
        //给模型中属性赋值
        if (value) {
            [objc setValue:value forKey:key];
        }
        NSLog(@"%@",ivarName);
    }
//    2.根据属性名去字典中查找value 3.给模型中属性赋值kvc
    
    
    return objc;
}
void test(int *count){
    *count = 3;
}
@end
