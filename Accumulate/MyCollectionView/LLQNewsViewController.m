//
//  LLQNewsViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 16/11/24.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import "LLQNewsViewController.h"

@interface LLQNewsViewController ()
@property(nonatomic,strong)UIScrollView *titleScrollView;
@property(nonatomic,strong)UIScrollView *contentScrollView;
@end

@implementation LLQNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark-----------创建标题滚动视图
-(void)setupTopTitleScrollView
{
    CGFloat y=self.navigationController.navigationBarHidden?20:64;
    UIScrollView *titleSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, 44)];
    [self.view addSubview:titleSV];
    _titleScrollView=titleSV;
}
#pragma mark-----------创建标题滚动视图
-(void)setupContentScrollView
{
    CGFloat y=CGRectGetMaxY(self.titleScrollView.frame);
    UIScrollView *contentSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height-y)];
    [self.view addSubview:contentSV];
    _contentScrollView=contentSV;
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
