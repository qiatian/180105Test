//
//  LLQNavigationViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 17/3/2.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "LLQNavigationViewController.h"

@interface LLQNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation LLQNavigationViewController
+(void)load
{
    UINavigationBar *navBar=[UINavigationBar appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
    
    //设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.interactivePopGestureRecognizer.delegate=self;//不让代理做事情
    //造成主界面假死。是因为代理
//    为什么导航控制器的手势不是全屏滑动。＝>
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate=self;
    
    self.interactivePopGestureRecognizer.enabled=NO;//禁止之前的手势
    
}
#pragma mark------UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count>1;//是不是根控制器，是的话不触发
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count>0) {
        //滑动返回功能被 手动设置按钮覆盖－－－分析：
        UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
        NSLog(@"%@",self.interactivePopGestureRecognizer);//手势
    }
    
    //真正跳转的代码
    [super pushViewController:viewController animated:animated];
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
