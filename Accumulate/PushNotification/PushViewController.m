//
//  PushViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 17/2/22.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//
/*推送通知， 应用场景： 一些任务管理app，会在任务时间即将到达时，通知你做该任务。
 本地推送：不联网， 开发人员负责在app内发送
 远程推送通知：联网，APNs服务器远程推送。
 推送通知呈现方式 多种。用户在通知中心设置。
 */
#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"add" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setFrame:CGRectMake(100, 200, 100, 100)];
    [btn2 setTitle:@"look" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(look) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn3 setFrame:CGRectMake(100, 300, 100, 100)];
    [btn3 setTitle:@"delete" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(clean) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
}
-(void)add//sendNotification
{
    //ios8.0以后，你需要主动的请求授权，才可以发送通知
    //1.创建本地通知
    UILocalNotification *locationNoti=[[UILocalNotification alloc]init];
    //1.1设置通知必选项
    locationNoti.alertBody = @"要不？？起床啦";
    //1.2设置通知触发时间 5秒后
    locationNoti.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    
    locationNoti.alertLaunchImage = @"";//iOS9.0之前有图片，之后没。
    locationNoti.alertTitle = @"RRRTest";//只对于通知中心的通知有效
    locationNoti.soundName = @"";//设置通知声音
    //图标右上角的数字设置(0代表不显示)
    locationNoti.applicationIconBadgeNumber = 10;
    //2.将配置好的文件加到操作系统中
    [[UIApplication sharedApplication] scheduleLocalNotification:locationNoti];
//    [[UIApplication sharedApplication] presentLocalNotificationNow:locationNoti];
    [self registerAuthor];
    
    
}
-(void) registerAuthor{
    if (iOS8Later) {
        UIUserNotificationSettings *sets = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        //    sets.types = UIUserNotificationTypeBadge;
        [[UIApplication sharedApplication] registerUserNotificationSettings:sets];
    }
    
}
-(void)look
{
    NSArray *arr = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSLog(@"%@",arr);
}
-(void)clean
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
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
