//
//  LLQPageView.m
//  BeautifyVastCollect
//
//  Created by sanjingrihua on 17/3/21.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "LLQPageView.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
static NSUInteger currentImage = 1;//记录中间图片的下标,开始总是为1
@implementation LLQPageView
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 添加子控件
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.pageConrol.hidesForSinglePage = YES;
    
    //开启定时器
    [self startTimer];
}
+(instancetype)pageView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
-(void)setImageNames:(NSArray *)imageNames
{
    _imageNames = imageNames;
    
    //delete old
    //    [self.topScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];_leftImageView.image = [UIImage imageNamed:_imageNameArray[0]];
    _topScroll.bounces = NO;
    _topScroll.contentSize = CGSizeMake(ScreenWidth*3, 0);
    [_topScroll setContentOffset:CGPointMake(ScreenWidth, 0) animated:NO];
    _topScroll.pagingEnabled = YES;
    _topScroll.showsHorizontalScrollIndicator = NO;
    _topScroll.delegate=self;
    
    self.pageConrol.numberOfPages=self.imageNames.count;
    
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, _topScroll.frame.size.height)];
    [_topScroll addSubview:_leftImageView];
    _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, _topScroll.frame.size.height)];
    [_topScroll addSubview:_centerImageView];
    _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*2, 0, ScreenWidth, _topScroll.frame.size.height)];
    [_topScroll addSubview:_rightImageView];
    
    
    _leftImageView.backgroundColor = imageNames[0];
    _centerImageView.backgroundColor = imageNames[1];
    _rightImageView.backgroundColor = imageNames[2];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reloadImage];
    //停止滚动，更新页面
//    int page = (int)(scrollView.contentOffset.x/ScreenWidth + 0.5)%self.imageNames.count;
//    _pageConrol.currentPage = page;
}
-(void)reloadImage
{
    CGPoint offset = [_topScroll contentOffset];
    if (offset.x==2*ScreenWidth) {
        currentImage = (currentImage+1)%self.imageNames.count;
        _pageConrol.currentPage = (_pageConrol.currentPage + 1)%self.imageNames.count;
    }else if (offset.x==0){
        currentImage = (currentImage-1)%self.imageNames.count;
        _pageConrol.currentPage = (_pageConrol.currentPage - 1)%self.imageNames.count;
    }
    else{
        return;
    }
    _leftImageView.backgroundColor = self.imageNames[(currentImage-1)%self.imageNames.count];
    
    _centerImageView.backgroundColor = self.imageNames[currentImage%self.imageNames.count];
    
    _rightImageView.backgroundColor = self.imageNames[(currentImage+1)%self.imageNames.count];
    
    
    _topScroll.contentOffset = CGPointMake(ScreenWidth, 0);
}
-(void)startTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
-(void)stopTimer
{
    [timer invalidate];
}
#pragma mark-----滚动到下一页
-(void)nextPage1
{
    int page = _topScroll.contentOffset.x/ScreenWidth + 1;
    
    if (page == self.imageNames.count) {
        page = 0;
    }
    
    [_topScroll setContentOffset:CGPointMake(page * _topScroll.frame.size.width, 0) animated:NO];
}
-(void)nextPage
{
    [self.topScroll setContentOffset:CGPointMake(ScreenWidth * 2, 0) animated:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
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



@end
