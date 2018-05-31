//
//  NewTestPerson.m
//  Accumulate
//
//  Created by sanjingrihua on 2018/5/22.
//  Copyright © 2018年 sanjingrihua. All rights reserved.
//

#import "NewTestPerson.h"

@implementation NewTestPerson
NSString *const name2;//不能改  修饰全局变量 只读
-(void)test{
    //class:获取当前方法调用者的类
    //superclass：获取当前方法调用者的父类
    //super:仅仅是一个编译指示器，就是给编译器看的，不是一个指针
    //本质： 只要编译器看到super这个标志，就会让当前对象去调用父类方法，本质还是当前对象在调用
//    [super test];
    //    修饰基本变量
//    int const a = 2;
//    //    a=5;不可修改
//
//    //修饰指针变量
//    int  i=3;
//    int y;
//    int const *p = &i;
//    i=5;
//    //    *p = 8;//被const修饰不可改
//    p = &y;
//
//    [self test:&i];
    
}
-(void)test:(int const*)a
{
    //    *a = 2;
}
@end
