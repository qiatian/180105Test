//
//  UIImage+LLQImage.m
//  Accumulation
//
//  Created by sanjingrihua on 17/5/4.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "UIImage+LLQImage.h"

@implementation UIImage (LLQImage)
+(instancetype)imageOriginalWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageOriginalWithName:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
-(instancetype)llq_circleImage
{
    //开启图形上下文   比例因素：当前点与像素比例
    UIGraphicsBeginImageContextWithOptions(self.size,NO,0);
//    描述裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
//    设置裁剪区域
    [path addClip];
//    画图片
    [self drawAtPoint:CGPointZero];
//    取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    关闭上下文
    UIGraphicsEndImageContext();
    return image;
}
+(instancetype)llq_circleImageNamed:(NSString *)name
{
    return [[self imageNamed:name] llq_circleImage];
}
@end
