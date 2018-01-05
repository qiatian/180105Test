//
//  LLQImage.m
//  Accumulation
//
//  Created by sanjingrihua on 17/5/27.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "LLQImage.h"

@implementation LLQImage
+(UIImage*)imageNamed:(NSString *)name
{
//    加载图片
    UIImage *image = [super imageNamed:name];
    if (image) {
        NSLog(@"加载成功");
    }else{
        NSLog(@"加载失败");
    }
    return image;
    
}
@end
