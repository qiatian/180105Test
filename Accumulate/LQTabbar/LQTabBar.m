//
//  LQTabBar.m
//  Accumulate
//
//  Created by sanjingrihua on 2018/1/8.
//  Copyright © 2018年 sanjingrihua. All rights reserved.
//

#import "LQTabBar.h"

@implementation LQTabBar
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    //设置允许交互的区域
    //转换点击在TabBar上的坐标点，到中间按钮上
    CGPoint pointInMiddleBtn = [self convertPoint:point toView:self.middleView];
    //确定中间按钮的圆心
    CGPoint middleBtnCenter = CGPointMake(33, 33);
    
    //计算点击的位置距离圆心的距离
    CGFloat distance = sqrt(pow(pointInMiddleBtn.x - middleBtnCenter.x, 2)+pow(pointInMiddleBtn.y - middleBtnCenter.y, 2));
    //判定中间按钮区域之外
    if (distance>33 && pointInMiddleBtn.y<18) {
        return NO;
    }
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
