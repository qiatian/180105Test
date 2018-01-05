//
//  HeaderCollectionReusableView.m
//  BeautifyVastCollect
//
//  Created by sanjingrihua on 17/3/20.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "HeaderCollectionReusableView.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define NavHeight 64
#define TextColor [UIColor grayColor]
@implementation HeaderCollectionReusableView
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    topScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/2)];
    topScroll.backgroundColor = [UIColor greenColor];
    topScroll.showsHorizontalScrollIndicator = NO;
    topScroll.delegate=self;
    [self addSubview:topScroll];
    
    NSArray *colorArr = [NSArray arrayWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor purpleColor],[UIColor orangeColor], nil];
    for (int i=0; i<4; i++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, topScroll.frame.size.height)];
        img.backgroundColor = colorArr[i];
        [topScroll addSubview:img];
    }
    topScroll.contentSize = CGSizeMake(ScreenWidth*colorArr.count, 0);
    topScroll.pagingEnabled = YES;
    
    [self startTimer];

    
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(0, topScroll.frame.size.height, ScreenWidth, NavHeight)];
    [self addSubview:btnView];
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"大牌区",@"爆款区",@"礼品区",@"特价区", nil];
    for (int i=0; i<titleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(ScreenWidth/titleArr.count*i, 0, ScreenWidth/titleArr.count, NavHeight);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.tag = i;
        [btn setTitleColor:TextColor forState:UIControlStateNormal];
        [btnView addSubview:btn];
    }
    
    UIView *imgView = [[UIView alloc]initWithFrame:CGRectMake(0, topScroll.frame.size.height+btnView.frame.size.height, ScreenWidth, NavHeight*3)];
    [self addSubview:imgView];
    
    NSArray *imgArr = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
    int totalloc = 2;
    CGFloat appvieww=ScreenWidth/2;
    CGFloat appviewh=NavHeight*3/2;
    for (int i=0; i<titleArr.count; i++) {
        int row=i/totalloc;//行号
        int loc=i%totalloc;//列号
        CGFloat appviewx=appvieww*loc;
        CGFloat appviewy=appviewh*row;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(appviewx, appviewy, appvieww, appviewh);
        [btn setTitle:imgArr[i] forState:UIControlStateNormal];
        btn.tag = i;
        [btn setTitleColor:TextColor forState:UIControlStateNormal];
        [imgView addSubview:btn];
    }
    
    UILabel *titLab = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-NavHeight/2, ScreenWidth, NavHeight/2)];
    titLab.text = @"三精鹊巢";
    titLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titLab];
}
-(void)startTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
-(void)stopTimer
{
    [timer invalidate];
    timer = nil;
}
#pragma mark-----滚动到下一页
-(void)nextPage
{
    int page = topScroll.contentOffset.x/ScreenWidth + 1;
    
    if (page == 4) {
        page = 0;
    }
    
    [topScroll setContentOffset:CGPointMake(page * topScroll.frame.size.width, 0) animated:YES];
}
#pragma mark-----用户即将开始拖拽 scrollview 时 ，停止定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
#pragma mark-----用户已经停止拖拽 scrollview 时 ，开始定时器
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
    if (decelerate == NO) {
        
    }
}
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    int page = scrollView.contentOffset.x/ScreenWidth;
//    pageControl.currentPage = page;
//}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x/ScreenWidth + 0.5);
    NSLog(@"%d",page);
//    pageControl.currentPage = page;
}
@end
