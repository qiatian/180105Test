//
//  LLQTabBar.m
//  Accumulation
//
//  Created by sanjingrihua on 17/2/28.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "LLQTabBar.h"
@interface LLQTabBar ()
@property(nonatomic,weak)UIButton *plusButton;
@end
@implementation LLQTabBar
-(UIButton*)plusButton{
    if (_plusButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];//懒加载控件时候，要调用这个
        
        [btn sizeToFit];
        
        _plusButton = btn;
    }
    return  _plusButton;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    LLQLog(@"123");
    CGFloat btnW = self.bounds.size.width/(self.items.count+1);
    CGFloat btnH = self.bounds.size.height;
    CGFloat x = 0;
    int i = 0 ;
//    UITabBarButton 是私有类
    for (UIView *tabbarBtn in self.subviews) {
        if ([tabbarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i==2) {
                i+=1;
            }
            x = i*btnW;
            tabbarBtn.frame = CGRectMake(x, 0, btnW, btnH);
            i++;
        }
    }
    
    //调整发布按钮位置
    self.plusButton.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
