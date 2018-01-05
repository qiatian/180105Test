//
//  LLQBuDeJieViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 17/2/24.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//
/*
 1.迭代开发（在原有基础上开发）
 2.独立开发
 LaunchScreen:Xcode6才开始。LaunchScreen好处：自动识别屏幕尺寸，只需提供一张图
 项目架构搭建：UI层  数据层   请求层
 
 UIApplication(打开网页，发短信，打电话；设置应用程序提醒数字；设置联网状态；设置状态栏）
 AppDelegate代理对象，并成为UIApplication代理（监听整个app生命周期，处理内存警告）
 开启主运行循环，保证程序一直运行（runloop:主线程有一个自动开启，每一个线程都有runloop）
 加载info.plist,判断是否指定main.storyboard。如果指定，就会加载
 
 项目架构搭建：主流结构（UITabBarController+导航控制器）
 tabbar应用
 
 谁的事情谁管理。
 
 //把UIButton包装成UIBarButtonItem,就导致按钮点击区域扩大。 可以把UIButton包装成UIView，然后赋值给UIBarButtonItem，就可以解决点击区域扩大的问题。
 
 搭建基本结构－>设置底部条－>设置顶部条－>设置顶部条标题字体－>处理导航控制器业务逻辑（跳转）
 
 跳转：底部条没有隐藏；处理返回按钮样式
 跳转前设置 隐藏底部tabBar self.hidesBottomBarWthenPushed=YES;
 返回按钮 由（通过）上一层控制器设置；当前控制器的左侧按钮（这个好）
 
 覆盖滑动返回功能，手势失效；手势代理影响，去掉手势代理。出现bug,假死状态，程序在运行，界面不能动。
 
 为什么导航控制器的手势不是全屏滑动。＝>
 
 每次程序启动的时候进入广告界面
 1.在启动的时候，加个广告界面－－－不能实现。
 2.在启动完成的时候，加广告界面
    a.程序一启动就进入广告界面，窗口的根控制器设置为广告控制器
    b.直接往窗口上再加上一个广告界面，等几秒过去了，再移除广告界面。(麻烦)
 */
#import "LLQBuDeJieViewController.h"

@interface LLQBuDeJieViewController ()

@end

@implementation LLQBuDeJieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
