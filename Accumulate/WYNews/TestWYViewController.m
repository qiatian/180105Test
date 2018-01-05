//
//  TestWYViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 17/6/5.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "TestWYViewController.h"

@interface TestWYViewController ()

@end

@implementation TestWYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //3. 添加所有子控制器
    [self setupAllChildViewController];
}
#pragma mark----添加所有子控制器
-(void)setupAllChildViewController
{
    //1
    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.title = @"社会";
    vc1.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:vc1];
    
    //2
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.title = @"头条";
    vc2.view.backgroundColor = [UIColor purpleColor];
    [self addChildViewController:vc2];
    
    //3
    UIViewController *vc3 = [[UIViewController alloc]init];
    vc3.title = @"热点";
    [self addChildViewController:vc3];
    //4
    UIViewController *vc4 = [[UIViewController alloc]init];
    vc4.title = @"视频";
    [self addChildViewController:vc4];
    
    //5
    UIViewController *vc5 = [[UIViewController alloc]init];
    vc5.title = @"笑话";
    [self addChildViewController:vc5];
    
    //6
    UIViewController *vc6 = [[UIViewController alloc]init];
    vc6.title = @"情感";
    [self addChildViewController:vc6];
    
    
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
