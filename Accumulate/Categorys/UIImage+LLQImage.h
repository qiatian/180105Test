//
//  UIImage+LLQImage.h
//  Accumulation
//
//  Created by sanjingrihua on 17/5/4.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LLQImage)
+(instancetype)imageOriginalWithName:(NSString *)imageName;
-(instancetype)llq_circleImage;
+(instancetype)llq_circleImageNamed:(NSString *)name;
@end
