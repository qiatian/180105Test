//
//  UIImage+Image.m
//  Accumulation
//
//  Created by sanjingrihua on 17/5/27.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "UIImage+Image.h"
#import <objc/message.h>
@implementation UIImage (Image)
//在分类中，最好不要重写系统方法，一旦重写，就把系统方法实现给干掉了。
//把泪加载进内存的时候调用，只会调用一次
+(void)load
{
    //获取imageNamed
    Method imgNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    //获取llq_imageNamed
    Method llq_imageNamedMethod = class_getClassMethod(self, @selector(llq_imageNamed:));
    //交换方法：runtime
    method_exchangeImplementations(imgNamedMethod, llq_imageNamedMethod);
}
//会调用多次
//+(void)initialize
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken,^{
//    });
//}
//加载图片 判断是非加载成功
+(UIImage*)llq_imageNamed:(NSString *)name
{
    UIImage *image = [UIImage llq_imageNamed:name];
    if (image) {
        NSLog(@"加载成功");
    }else{
        NSLog(@"加载失败");
    }
    return image;
}
@end
