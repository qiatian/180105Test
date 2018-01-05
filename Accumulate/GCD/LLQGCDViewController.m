//
//  LLQGCDViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 17/7/6.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "LLQGCDViewController.h"

@interface LLQGCDViewController ()
@property(nonatomic,strong)UIImage *img1;
@property(nonatomic,strong)UIImage *img2;
@end

@implementation LLQGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)forDemo
{
    //for循环是同步的
    for(NSInteger i=0;i<10;i++){
        NSLog(@"for---%@",[NSThread currentThread]);
    }
}
-(void)applyDemo{
//    GCD快速迭代  参数1:要遍历的次数 参数2:队列，只能传并发队列 参数3:index 索引，执行迭代任务  开启子线程，并发执行，和主线程一起完成遍历任务
    dispatch_apply(10, dispatch_get_global_queue(0, 0), ^(size_t index) {
        NSLog(@"for---%@",[NSThread currentThread]);
    });
}
-(void)moveFile{
    //拿到文件目录 路径
    NSString *from = @"/Users/sanjingrihua/Desktop/old切图页面";
//    获取目标文件路径
    NSString *to = @"/Users/sanjingrihua/Desktop/New";
//    得到目录下面的所有文件
    NSArray *subPaths = [[NSFileManager defaultManager]subpathsAtPath:from];
//    遍历所有文件，然后执行剪切操作
    NSInteger count = subPaths.count;
    
    for (NSInteger i=0; i<count; i++) {
        //拼接全路径
//        NSString *fullPath = [from stringByAppendingString:subPaths[i]];少／斜杠
        NSString *fullPath = [from stringByAppendingPathComponent:subPaths[i]];//拼接时候会自动添加／
        NSString *tofullPath = [to stringByAppendingPathComponent:subPaths[i]];
//        执行剪切操作
        [[NSFileManager defaultManager]moveItemAtPath:fullPath toPath:tofullPath error:nil];

    }
    
}
-(void)moveFileWithGCD
{
    //拿到文件目录 路径
    NSString *from = @"/Users/sanjingrihua/Desktop/old切图页面";
    //    获取目标文件路径
    NSString *to = @"/Users/sanjingrihua/Desktop/New";
    //    得到目录下面的所有文件
    NSArray *subPaths = [[NSFileManager defaultManager]subpathsAtPath:from];
    //    遍历所有文件，然后执行剪切操作
    NSInteger count = subPaths.count;
    
    dispatch_apply(count, dispatch_get_global_queue(0, 0), ^(size_t index) {
        NSString *fullPath = [from stringByAppendingPathComponent:subPaths[index]];//拼接时候会自动添加／
        NSString *tofullPath = [to stringByAppendingPathComponent:subPaths[index]];
        //        执行剪切操作
        [[NSFileManager defaultManager]moveItemAtPath:fullPath toPath:tofullPath error:nil];
    });
}
//队列组
-(void)queueArr{
    //创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //创建队列组
    dispatch_group_t group = dispatch_group_create();
    
    //队列组函数  封装任务，把任务添加到队列中，会监听任务的执行情况，并通知group
    dispatch_group_async(group, queue, ^{
        NSLog(@"0---%@",[NSThread currentThread]);
    });
//    异步函数 封装任务，把任务添加到队列中 
//    dispatch_async(queue, ^{
//        NSLog(@"1---%@",[NSThread currentThread]);
//    });
    dispatch_group_async(group,queue, ^{
        NSLog(@"2---%@",[NSThread currentThread]);
    });
    dispatch_group_async(group,queue, ^{
        NSLog(@"3---%@",[NSThread currentThread]);
    });
    //拦截通知，当队列组中所有的任务都执行完毕的时候会进入到下边的方法 执行下边的方法时候，队列组中所有的任务都执行完毕
    dispatch_group_notify(group, queue, ^{
        NSLog(@"dispatch_group_notify");
    });
}
-(void)queueArrOld{
    //创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //创建队列组
    dispatch_group_t group = dispatch_group_create();
    
    //在该方法后面的异步任务会被纳入到队列组的监听范围，进入群组  dispatch_group_enter和dispatch_group_leave要配对使用
    dispatch_group_enter(group);
    
    dispatch_async(queue, ^{
                NSLog(@"1---%@",[NSThread currentThread]);
        //离开群组
        dispatch_group_leave(group);
    });
    
    //拦截通知，问题，该方法是阻塞的吗？  内部本身是异步的
    dispatch_group_notify(group, queue, ^{
        NSLog(@"dispatch_group_notify");
    });
    
    //等待 队列组的任务  死等，直到队列组中的所有任务都执行完毕之后才执行  本身是阻塞的。
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    NSLog(@"end");
}
-(void)group3{
    
    //下载图片1 开子线程，下载图片2 开子线程，合成图片 开子线程  需要依赖之前的操作
    
    //获得并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //创建队列组
    dispatch_group_t group = dispatch_group_create();
    //下载图片1 开子线程
    dispatch_group_async(group,queue, ^{
       
//        确定url
        NSURL *url = [NSURL URLWithString:@""];
        //下载二进制数据
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        
//        转换图片
        self.img1 = [UIImage imageWithData:imgData];
    });
    
//    下载图片2 开子线程
    dispatch_group_async(group,queue, ^{
        
        //        确定url
        NSURL *url = [NSURL URLWithString:@""];
        //下载二进制数据
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        
        //        转换图片
        self.img2 = [UIImage imageWithData:imgData];
    });
    
    //合并图片
    dispatch_group_notify(group, queue, ^{
        //创建图形上下文
        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        
//        画图
        [self.img1 drawInRect:CGRectMake(0, 0, 200, 100)];
        [self.img2 drawInRect:CGRectMake(0, 100, 200, 100)];
//        根据上下文得到一张图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//        关闭上下文
        UIGraphicsEndImageContext();
//        更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@--%@",image,[NSThread currentThread]);
        });
    });
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
