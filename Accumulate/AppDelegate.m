//
//  AppDelegate.m
//  Accumulate
//
//  Created by sanjingrihua on 2017/11/20.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "AppDelegate.h"
#import "BasisViewController.h"
#import "SocketViewController.h"
#import <string.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //素数
//    [self sushu];
    //冒泡排序
//    [self maopaoPaiXu];
//    strcmp(<#const char *__s1#>, <#const char *__s2#>)
    
    //i指针问题
//    [self zhizhen];

    //    1.创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
//    2.设置窗口根控制器
//    BasisViewController *bvc = [[BasisViewController alloc]init];
//    self.window.rootViewController = bvc;
    
    SocketViewController *svc = [[SocketViewController alloc]init];
    self.window.rootViewController = svc;
    
    //    3.显示窗口
    [self.window makeKeyWindow];
    
    return YES;
}
- (void)sushu{
    //素数
    for (int i=1; i<1000; i++) {
        for (int j=2; j<i; j++) {
            if (i%j==0) {
                break;
            }
            if (j>sqrt(i)) {
                NSLog(@"素数%d",i);
                break;
            }
        }
    }
}
- (void)maopaoPaiXu{
    //冒泡排序
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:3],[NSNumber numberWithInteger:2],[NSNumber numberWithInteger:4],[NSNumber numberWithInteger:1],[NSNumber numberWithInteger:5], nil];
    
    for (int i=0; i<arr.count; i++){
        NSLog(@" 排序前：%@",arr[i]);
    }
    
    for (int i=0; i<arr.count; i++) {
        for (int j=0; j<arr.count-i-1; j++) {
            if (arr[j]>arr[j+1]) {
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
    for (int i=0; i<arr.count; i++){
        NSLog(@" 排序后：%@",arr[i]);
    }
}
-(void)zhizhen{
    //i指针问题
    int a = 10;
    const int *p = &a;
    int const *p2 = &a;
    //    *p2 = 200;
    //指针指向的值不能修改，指针可以修改
    //    *p = 100;
    int b = 20;
    p = &b;
    p2 = &b;
    
    int * const p1 = &a;
    *p1 = 100;
    //指针指向的值能修改，指针不可以修改
    //    p1 = &b;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
