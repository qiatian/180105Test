//
//  LLQHandleImageView.h
//  Accumulation
//
//  Created by sanjingrihua on 16/11/29.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLQHandleImageView;
@protocol llqhandleImageViewDelegate <NSObject>

- (void)handleImageView:(LLQHandleImageView *)handleImageView newImage:(UIImage *)newImage;

@end
@interface LLQHandleImageView : UIView
/** <#注释#> */
@property (nonatomic, strong) UIImage *image;

/** <#注释#> */
@property (nonatomic, weak) id<llqhandleImageViewDelegate> delegate;
@end
