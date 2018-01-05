//
//  Person.m
//  Accumulation
//
//  Created by sanjingrihua on 17/5/27.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>
@implementation Person
void aaa(id self,SEL _cmd,NSNumber *meter){
    NSLog(@"跑了%@",meter);
}
//什么时候调用：只要一个对象调用了一个未实现的方法就会调用这个方法，进行处理
//作用：动态添加方法，处理未实现
+(BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"%@",NSStringFromSelector(sel));
    //动态添加方法 [NSStringFromSelector(sel) isEqualToString:@"play"]
    if (sel == NSSelectorFromString(@"run:")) {
        //class：给哪个类添加方法 IMP： 方法实现＝》函数＝》函数入口＝》函数名 type：方法类型
        class_addMethod(self, sel, (IMP)aaa, "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
//-(void)run:(NSInteger)meter
//{
//    NSLog(@"跑了%ld",(long)meter);
//}
-(void)eat
{
    NSLog(@"eat meat");
}
//-(void)test{
//    NSLog(@"%@",NSStringFromSelector(sel));
//    //动态添加方法 [NSStringFromSelector(sel) isEqualToString:@"play"]
//    if (sel == NSSelectorFromString(@"play")) {
//        //class：给哪个类添加方法 IMP： 方法实现＝》函数＝》函数入口＝》函数名 type：方法类型
//        class_addMethod(self, sel, (IMP)aaa, "v@:");
//return YES;

//    }
//    return [super resolveInstanceMethod:sel];
//}
-(void)test{
    NSLog(@"------%@------%@---%@----%@",[self class],[super class],[self superclass],[super superclass]);
}
@end
