//
//  SubPerson.m
//  Accumulation
//
//  Created by sanjingrihua on 17/5/31.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "SubPerson.h"
//const与宏的区别: 1.编译时期：宏：预编译 const：编译 2.编译检查： 宏没有编译检查，const有编译检查  宏的好处：可以定义函数方法，const不可以定义方法函数
/*
 const作用：1.修饰右边基本变量或指针变量 2.被const修饰变量只读。
 使用场景用法：1.修饰全局变量 ->代替宏 2.修饰方法中参数
 */
/*
 static作用：1.修饰局部变量，被static修饰的局部变量，会延长生命周期，跟整个应用程序有关；被static修饰的局部变量，只会分配一次内存；被static修饰的局部变量，什么时候分配内存？程序一运行就会给static修饰的变量分配内存
 2.修饰全局变量，被const修饰全局变量，作用域会修改，只能在当前文件下使用。
extern：声明外部全局变量 注意：只能声明，不能用于定义。
 extern工作原理：先会去当前文件下查找有没有对应全局变量，如果没有，才会去其他文件查找
 */
//static和const联合使用
@implementation SubPerson
NSString *const name1;//不能改  修饰全局变量 只读
-(void)test{
    //class:获取当前方法调用者的类
    //superclass：获取当前方法调用者的父类
    //super:仅仅是一个编译指示器，就是给编译器看的，不是一个指针
    //本质： 只要编译器看到super这个标志，就会让当前对象去调用父类方法，本质还是当前对象在调用
//    [super test];
//    修饰基本变量
//    int const a = 2;
////    a=5;不可修改
//
//    //修饰指针变量
//    int  i=3;
//    int y;
//    int const *p = &i;
//    i=5;
////    *p = 8;//被const修饰不可改
//    p = &y;
//
//    [self test:&i];
    
}
-(void)test:(int const*)a
{
//    *a = 2;
}
@end
