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
#import "Block1ViewController.h"
#import <string.h>
@interface AppDelegate ()
@property(nonatomic,strong)NSString *strongStr;
@property(nonatomic,copy)NSString *copyedStr;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //素数
//    [self sushu];
    //冒泡排序
//    [self maopaoPaiXu];
//    [self charuSort];
//    [self testStr];
//    strcmp(<#const char *__s1#>, <#const char *__s2#>)
    
    //i指针问题
//    [self zhizhen];

    //    1.创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
//    2.设置窗口根控制器
//    BasisViewController *bvc = [[BasisViewController alloc]init];
//    self.window.rootViewController = bvc;
    
//    SocketViewController *svc = [[SocketViewController alloc]init];
    Block1ViewController *bvc = [[Block1ViewController alloc]init];
    self.window.rootViewController = bvc;
    
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
    
    NSLog(@" 排序后：%@",arr);
    
    //选择排序
    NSMutableArray *selectArr = [NSMutableArray arrayWithObjects:@"34",@"23",@"14",@"36",@"25", nil];
    NSUInteger count = selectArr.count;
    for (int i=0; i<count-1; i++) {
        for (int j = i+1; j<count; j++) {
            if ([selectArr[i] integerValue]>[selectArr[j] integerValue]) {
                NSInteger temp = [selectArr[i] integerValue];
                selectArr[i] = selectArr[j];
                selectArr[j] = [NSString stringWithFormat:@"%ld",(long)temp];
            }
        }
    }
    NSLog(@"选择排序result：%@",selectArr);
}
- (void)charuSort{
    NSMutableArray *listArr = [NSMutableArray arrayWithObjects:@"34",@"23",@"14",@"36",@"25", nil];
    NSUInteger count = listArr.count;
    for (int i=1; i<count; i++) {
        int j=i;
        NSInteger temp = [listArr[i] integerValue];
        
        while (j>0 && temp<[listArr[j-1] integerValue]) {
            [listArr replaceObjectAtIndex:j withObject:listArr[j-1]];
            j--;
        }
        [listArr replaceObjectAtIndex:j withObject:[NSNumber numberWithInteger:temp]];
        
    }
    NSLog(@"result:%@",listArr);
}
//希尔排序
- (void)xierSort{
    NSMutableArray *listArr = [NSMutableArray arrayWithObjects:@"34",@"23",@"14",@"36",@"25", nil];
    NSUInteger count = listArr.count;
    NSUInteger gap = listArr.count/2;
    while (gap>=1) {
        for (NSInteger i = gap; i<count; i++) {
            NSInteger temp = [[listArr objectAtIndex:i] integerValue];
            NSInteger j = i;
            while (j>=gap && temp<[listArr[j-gap] integerValue]) {
                [listArr replaceObjectAtIndex:j withObject:listArr[j-gap]];
                j-=gap;
            }
            [listArr replaceObjectAtIndex:j withObject:[NSNumber numberWithInteger:temp]];
        }
        gap = gap/2;
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
- (void)testStr{
    NSString *string = [NSString stringWithFormat:@"hhh"];
    self.strongStr = string;
    self.copyedStr = string;
    NSLog(@"before%@,%@",self.strongStr,self.copyedStr);
    string = @"hello";
    NSLog(@"after%@,%@",self.strongStr,self.copyedStr);
}
//快速排序
-(void)quickSequence:(NSMutableArray *)arr andleft:(int)left andright:(int)right
{
    if (left >= right) {//如果数组长度为0或1时返回
        return ;
    }
    int key = [arr[left] intValue];
    int i = left;
    int j = right;
    
    while (i<j){
        while (i<j&&[arr[j] intValue]>=key) {
            j--;
        }
        arr[i] = arr[j];
        
        while (i<j&&[arr[i] intValue]<=key) {
            i++;
        }
        arr[j] = arr[i];
    }
    arr[i] = [NSString stringWithFormat:@"%d",key];
    [self quickSequence:arr andleft:left andright:i-1];
    [self quickSequence:arr andleft:i+1 andright:right];
}
- (void)deleteSomeCharacter{
    NSMutableString * str1 = [[NSMutableString alloc] initWithFormat:@"aabcad"];
    
    for (int i = 0; i < str1.length - 1; i++) {
        
        for (int j = i + 1; j < str1.length ; j++) {
            
            // 由于字符的特殊性  无法使用 字符串 isEqualToString 进行比较 只能转化为ASCII 值进行比较  所以 需要加 unsigined 修饰
            unsigned char a = [str1 characterAtIndex:i];
            
            unsigned char b = [str1 characterAtIndex:j];
            
            if (a == b) {
                
                if (j - i > 1) {
                    
                    // NSRange:  截取字符串  {j, 1} j: 第一个字符开始  1: 截取几个字符
                    NSRange  range = {j, 1};
                    
                    [str1 deleteCharactersInRange:range];
                    
                    j = i--;
                }
            }
        }
    }
    NSLog(@"------ %@-------", str1);
}

//假设有一个字符串aabcad,请编写一段程序，去掉字符串中不相邻的重复字符。即上述字串处理之后结果是为：aabcd
-(void) removeRepeat:(NSString *)aNum
{
    
    NSMutableArray *mArr = [[NSMutableArray alloc]initWithCapacity:10];
    
    for(int i = 0; i<aNum.length; i++)
        
    {
        
        [mArr addObject:[aNum substringWithRange:NSMakeRange(i,1)]];
        
    }
    
    NSLog(@"%@",mArr);
    
    [self compareNum:mArr];
    
    NSLog(@"%@",mArr);
    
}
//  比较是否相等

-(NSMutableArray *)compareNum:(NSMutableArray *)mArr

{
    
    int count  = mArr.count; // 重新定义了count不会减1
    
    for(int j = 0; j< count - 1 ;j++)
        
    {
        
        for(int i = j;i < count -1-1-1;i++)
            
        {
            
            NSLog(@"%@  %@",[mArr objectAtIndex:j],[mArr objectAtIndex:i + 2]);
            
            NSString *a = [mArr objectAtIndex:j];
            
            NSString *b = [mArr objectAtIndex:i+2];
            
            if([a isEqualToString:b])
                
            {
                
                [mArr replaceObjectAtIndex:i + 2 withObject:@" "];
                
            }
            
        }
        
    }
    
    return mArr;
    
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
