//
//  LLQDrawView.h
//  Accumulation
//
//  Created by sanjingrihua on 16/11/29.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLQDrawView : UIView
-(void)clear;//清屏
-(void)undo;//撤销
-(void)erase;//橡皮擦
-(void)setLineWith:(CGFloat)lineWidth;//设置线宽度
-(void)setLineColor:(UIColor*)color;//设置线颜色
@property(nonatomic,strong)UIImage *img;//要绘制的图片
@end
