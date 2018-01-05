//
//  LLQPageView.h
//  BeautifyVastCollect
//
//  Created by sanjingrihua on 17/3/21.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLQPageView : UIView<UIScrollViewDelegate>
{
    NSTimer *timer;
    int currentImageIndex;
    //循环滚动的三个视图
    UIImageView * _leftImageView;
    UIImageView * _centerImageView;
    UIImageView * _rightImageView;
}
@property (weak, nonatomic) IBOutlet UIScrollView *topScroll;
@property (weak, nonatomic) IBOutlet UIPageControl *pageConrol;
@property(nonatomic,strong)NSArray *imageNames;
+ (instancetype)pageView;
@end
