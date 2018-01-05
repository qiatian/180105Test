//
//  LLQAdTurnsViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 16/11/25.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import "LLQAdTurnsViewController.h"
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface LLQAdTurnsViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray *sourceArr;
@property (nonatomic) NSUInteger index;
@property (nonatomic) CGRect currentRect;
@end

@implementation LLQAdTurnsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupScrollView];
    
}
-(void)setupScrollView
{
    UIScrollView *sv=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 200)];
    sv.delegate=self;
    sv.backgroundColor=[UIColor whiteColor];
    sv.pagingEnabled=YES;
    [self.view addSubview:sv];
    _scrollV=sv;
    _currentRect=sv.frame;
    
    UIPageControl *pageCon=[[UIPageControl alloc]initWithFrame:CGRectMake(0, sv.frame.size.height-20+64, ScreenWidth, 20)];
    pageCon.numberOfPages=5;
    pageCon.backgroundColor=[UIColor purpleColor];
    [self.view addSubview:pageCon];
    _pageCon=pageCon;
    
    NSMutableArray *imgs=[[NSMutableArray alloc]initWithCapacity:0];
    for (int i=0; i<3; i++) {
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*i, 8, ScreenWidth, 160)];
//        imgView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]];
        imgView.tag=i+1;
        [_scrollV addSubview:imgView];
        [imgs addObject:[NSString stringWithFormat:@"%d.png",i+1]];
    }
    _scrollV.contentSize=CGSizeMake(ScreenWidth*3, 0);
    
    [self setupImageViewImg:imgs];
}
-(void)setupImageViewImg:(NSArray*)sourcelist
{
    NSMutableArray *tempArr=[NSMutableArray arrayWithArray:sourcelist];
    UIImageView *firstImg=(UIImageView*)[_scrollV viewWithTag:1];
    UIImageView *TwoImg=(UIImageView*)[_scrollV viewWithTag:2];
    UIImageView *ThreeImg=(UIImageView*)[_scrollV viewWithTag:3];
    self.index = 0;
    for (id obj in tempArr) {
        if (![obj isKindOfClass:[NSString class]]) {
            [tempArr removeObject:obj];
        }
    }
    
    if (tempArr.count>0) {
        if (sourcelist.count==1) {
            [tempArr addObject:[tempArr objectAtIndex:0]];
            [tempArr addObject:[tempArr objectAtIndex:0]];
            firstImg.image=[UIImage imageNamed:tempArr[0]];
            TwoImg.image=[UIImage imageNamed:tempArr[0]];
            ThreeImg.image=[UIImage imageNamed:tempArr[0]];
        }else if (sourcelist.count==2){
            [tempArr addObject:[tempArr objectAtIndex:0]];
            firstImg.image=[UIImage imageNamed:tempArr[0]];
            TwoImg.image=[UIImage imageNamed:tempArr[1]];
            ThreeImg.image=[UIImage imageNamed:tempArr[2]];
        }
        else{
            firstImg.image=[UIImage imageNamed:tempArr[tempArr.count-1]];
            TwoImg.image=[UIImage imageNamed:tempArr[0]];
            ThreeImg.image=[UIImage imageNamed:tempArr[1]];
        }
        self.sourceArr=tempArr;
        _pageCon.numberOfPages=self.sourceArr.count;
    }
    
    
}
#pragma mark---------UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.scrollV) {
        //三个图uiimageview交替部分
        if (self.scrollV.contentOffset.x == 0) {
            
            if (self.index == 0) {
                
                self.index = self.sourceArr.count - 1;
                [self setPicWithIndex:2 withImage:[UIImage imageNamed:[self.sourceArr objectAtIndex:self.index]]];
                [self.scrollV setContentOffset:CGPointMake(self.currentRect.size.width, 0)];
                [self setPicWithIndex:1 withImage:[UIImage imageNamed:[self.sourceArr objectAtIndex:self.index - 1]]];
                [self setPicWithIndex:3 withImage:[UIImage imageNamed:[self.sourceArr objectAtIndex:0]]];
                
            }else{
                
                self.index --;
                [self setPicWithIndex:2 withImage:[UIImage imageNamed:[self.sourceArr objectAtIndex:self.index]]];
                [self.scrollV setContentOffset:CGPointMake(self.currentRect.size.width, 0)];
                
                if (self.index == 0) {
                    
                    [self setPicWithIndex:1 withImage:[UIImage imageNamed:[self.sourceArr objectAtIndex:self.sourceArr.count - 1]]];
                    
                }else{
                    
                    [self setPicWithIndex:1 withImage:[UIImage imageNamed:[self.sourceArr objectAtIndex:self.index - 1]]];
                    
                }
                
                [self setPicWithIndex:3 withImage:[UIImage imageNamed:[self.sourceArr objectAtIndex:self.index + 1]]];
                
            }
            
            
        }else if (self.scrollV.contentOffset.x == self.currentRect.size.width * 2){
            
            if (self.index == self.sourceArr.count - 1) {
                
                self.index = 0;
                [self setPicWithIndex:2 withImage:[UIImage imageNamed:[self.sourceArr objectAtIndex:self.index]]];
                [self.scrollV setContentOffset:CGPointMake(self.currentRect.size.width, 0)];
                [self setPicWithIndex:1 withImage:[UIImage imageNamed:[self.sourceArr objectAtIndex:self.sourceArr.count - 1]]];
                [self setPicWithIndex:3 withImage:[UIImage imageNamed:[self.sourceArr objectAtIndex:self.index + 1]]];
                
                
                
            }else{
                
                self.index ++;
                [self setPicWithIndex:2 withImage:[UIImage imageNamed:[self.sourceArr objectAtIndex:self.index]]];
                [self.scrollV setContentOffset:CGPointMake(self.currentRect.size.width, 0)];
                [self setPicWithIndex:1 withImage:[UIImage imageNamed:[self.sourceArr objectAtIndex:self.index - 1]]];
                
                if (self.index == self.sourceArr.count - 1) {
                    
                    [self setPicWithIndex:3 withImage:[UIImage imageNamed:[self.sourceArr objectAtIndex:0]]];
                    
                }else{
                    
                    [self setPicWithIndex:3 withImage:[UIImage imageNamed:[self.sourceArr objectAtIndex:self.index + 1]]];
                    
                }
                
            }
            
            
        }
        
    }
    
}
//设置图片
-(void)setPicWithIndex:(NSUInteger)index withImage:(UIImage *)img{
    
    UIImageView *indexView = (UIImageView *)[self.scrollV viewWithTag:index];
    indexView.image = img;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
