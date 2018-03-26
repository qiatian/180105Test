//
//  LLQMoreThreadViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 16/11/30.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import "LLQMoreThreadViewController.h"
#define kURL @"http://avatar.csdn.net/2/C/D/1_totogo2010.jpg"
@interface LLQMoreThreadViewController ()
{
    UIImageView *_imageView;
}
@end

@implementation LLQMoreThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutUI];
    
    [self testGCDgroup];
    
    [self testGCDBarrier];
    
}
-(void)testGCDgroup
{
//    dispatch_group_async可以实现监听一组任务是否完成
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"group1");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"group2");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"group3");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"updateUi");  
    });
    
//    dispatch_release(group);
}
-(void)testGCDBarrier
{
//    dispatch_barrier_async是在前面的任务执行结束后它才执行，而且它后面的任务等它执行完成之后才会执行
    dispatch_queue_t queue=dispatch_queue_create("gcdtest.rongfzh.yc", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"dispatch_async1");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"dispatch_async2");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"barrier_async");
        [NSThread sleepForTimeInterval:5];
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"dispatch_async3");
    });
    
//    dispatch_apply执行某个代码片段N次
}
#pragma mark 界面布局
-(void)layoutUI{
    //[UIScreen mainScreen].applicationFrame
    _imageView =[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _imageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 500, 220, 25);
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    //添加方法
//    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
//    [button addTarget:self action:@selector(loadImageWithNSOperationMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(loadImageWithGCDMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
#pragma mark 将图片显示到界面
-(void)updateImage:(NSData *)imageData{
    //转换图片格式
    UIImage *image=[UIImage imageWithData:imageData];
    //显示UI
    _imageView.image=image;
}

#pragma mark 请求图片数据
-(NSData *)requestData{
    
    CFTimeInterval startC = CFAbsoluteTimeGetCurrent();//Double类型
    NSDate *start = [NSDate date];//获得当前的时间
    //对于多线程操作建议把线程操作放到@autoreleasepool中
    @autoreleasepool {
        //确定URL
        NSURL *url=[NSURL URLWithString:@"http://avatar.csdn.net/2/C/D/1_totogo2010.jpg"];
        //根据URL把图片下载到本地；图片是二进制数据
        NSData *data=[NSData dataWithContentsOfURL:url];
        NSDate *end = [NSDate date];//获得当前的时间
        CFTimeInterval endC = CFAbsoluteTimeGetCurrent();
        NSLog(@"%f",endC - startC);
        NSLog(@"%f",[end timeIntervalSinceDate:start]);//获得代码段执行时间
        return data;
    }
}

#pragma mark 加载图片
-(void)loadImage{
    //请求数据
    NSData *data= [self requestData];
    /*将数据显示到UI控件,注意只能在主线程中更新UI,
     另外performSelectorOnMainThread方法是NSObject的分类方法，每个NSObject对象都有此方法，
     它调用的selector方法是当前调用控件的方法，例如使用UIImageView调用的时候selector就是UIImageView的方法
     Object：代表调用方法的参数,不过只能传递一个参数(如果有多个参数请使用对象进行封装)
     waitUntilDone:是否线程任务完成执行
     */
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:data waitUntilDone:YES];
    
    //方式二 直接调用方法刷新图片
    UIImage *image=[UIImage imageWithData:data];
    [_imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
}

#pragma mark 多线程下载图片
-(void)loadImageWithMultiThread{
    //方法1：使用对象方法
    //创建一个线程，第一个参数是请求的操作，第二个参数是操作方法的参数
        NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(loadImage) object:nil];
    //    //启动一个线程，注意启动一个线程并非就一定立即执行，而是处于就绪状态，当系统调度时才真正执行  线程启动之前设置属性
        thread.name = @"线程ABV";
    thread.threadPriority = UILayoutPriorityDefaultHigh;//设置优先级范围0.0～1.0.默认0.5；

        [thread start];
    
    //方法2：使用类方法
    [NSThread detachNewThreadSelector:@selector(loadImage) toTarget:self withObject:nil];
    
    //方法3：
    [self performSelectorInBackground:@selector(loadImage) withObject:nil];
}
#pragma mark-----------NSOperation
-(void)loadImageWithNSOperationMultiThread
{
    NSInvocationOperation *operation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(downLoadImage:) object:kURL];
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    [queue addOperation:operation];
}
-(void)downLoadImage:(NSString*)url
{
    NSDate *start = [NSDate date];
    CFTimeInterval start1 = CFAbsoluteTimeGetCurrent();
    
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSData *data = [[NSData alloc]initWithContentsOfURL:nsUrl];
    UIImage * image = [[UIImage alloc]initWithData:data];
    
    NSDate *end = [NSDate date];
    CFTimeInterval end1 = CFAbsoluteTimeGetCurrent();
    NSLog(@"%f---%f",[end timeIntervalSinceDate:start],end1-start1);
    
    
    
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
}
-(void)updateUI:(UIImage*) image{
    _imageView.image = image;
}
#pragma mark------loadImageWithGCDMultiThread
-(void)loadImageWithGCDMultiThread
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        确定URL
        NSURL *url=[NSURL URLWithString:kURL];
//        根据URL下载图片二进制数据到本地
        NSData *data=[[NSData alloc]initWithContentsOfURL:url];
//        转换图片格式
        UIImage *img=[[UIImage alloc]initWithData:data];
//        显示UI
        if (data!=nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _imageView.image=img;
            });
        }
    });
}
#pragma mark------GCD 异步函数+并发队列:开启多条线程，异步执行
-(void)asyncConcurrent
{
//    1.创建队列
    dispatch_queue_t queue = dispatch_queue_create("com.llq.download", DISPATCH_QUEUE_CONCURRENT);
//    获取全局并发队列
    dispatch_queue_t q2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"q2直接拿来用的%@，queue自己创建的",q2);
//    2.封装任务
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
}
#pragma mark------GCD 异步函数+串行队列:开启一条线程，串行执行
-(void)asyncSerial
{
    dispatch_queue_t queue = dispatch_queue_create("llllqqq", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
}
#pragma mark------GCD 同步函数+并发队列:不会开线程，串行执行
-(void)syncConcurrent
{
    //    1.创建队列
    dispatch_queue_t queue = dispatch_queue_create("com.llq.download", DISPATCH_QUEUE_CONCURRENT);
    //    2.封装任务
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
}
#pragma mark------GCD 同步函数+串行队列:不会开线程，串行执行
-(void)syncSerial
{
    //    1.创建队列
    dispatch_queue_t queue = dispatch_queue_create("com.llq.download", DISPATCH_QUEUE_SERIAL);
    //    2.封装任务
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
}
#pragma mark------异步函数＋主队列:所有任务都在主线程中执行，不会开线程
-(void)asyncMain
{
    //获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    //异步函数
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
}
#pragma mark------同步函数（立刻马上执行，如果我没有执行完毕，那么后边的操作也别想执行）＋主队列:死锁－－主队列发现当前主线程有任务在执行，主队列会暂停调用队列中的任务，直到主线程空闲为止。
-(void)syncMain
{
    [NSThread detachNewThreadSelector:@selector(syncMain) toTarget:self withObject:nil];
    //获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    //异步函数
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
}
-(void)delayTest
{
//    1.延迟执行的方法
    [self performSelector:@selector(taskTest) withObject:nil afterDelay:2.0f];
    //    2.延迟执行的方法
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(taskTest) userInfo:nil repeats:YES];
    //    3.GCD延迟执行的方法
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);//dispatch_get_main_queue();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), queue, ^{
         NSLog(@"%@",[NSThread currentThread]);
    });
}
-(void)taskTest
{
    NSLog(@"%@",[NSThread currentThread]);
}
#pragma mark-----一次性代码 不能放在懒加载中
-(void)onceTest
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"once");
    });
}
#pragma mark-----栅栏函数:不能使用全局并发队列  控制队列任务执行顺序  前面任务的执行顺不能控制，前面执行完才执行 栅栏函数方法后的 任务
-(void)boomTest
{
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    dispatch_barrier_async(queue, ^{
        NSLog(@"dddd");
    });
    
//    GCD快速迭代 遍历次数，队列，索引  开子线程和主线程一起完成遍历任务，并发执行任务
    dispatch_apply(10, dispatch_get_global_queue(0, 0), ^(size_t index) {
        NSLog(@"%@",[NSThread currentThread]);
    });
}
-(void)moveFileTest{
//    1.拿到文件路径
    NSString *from = @"";
//    2.获得目标文件路径
    NSString *to = @"";
//    3.得到目录下面的所有文件
    NSArray *subPaths = [[NSFileManager defaultManager] subpathsAtPath:from];
    NSLog(@"%@",subPaths);
    
    for (int i = 0; i<subPaths.count; i++) {
//        拼接文件的全路径
//        NSString *fullPath = [from stringByAppendingString:subPaths[i]];//少一个斜 杠
        NSString *fullPath = [from stringByAppendingPathComponent:subPaths[i]];
        NSString *toFullPath = [to stringByAppendingPathComponent:subPaths[i]];
//        执行剪切操作
        [[NSFileManager defaultManager] moveItemAtPath:fullPath toPath:toFullPath error:nil];
    }

}
-(void)moveFileWithGCD
{
    //    1.拿到文件路径
    NSString *from = @"";
    //    2.获得目标文件路径
    NSString *to = @"";
    //    3.得到目录下面的所有文件
    NSArray *subPaths = [[NSFileManager defaultManager] subpathsAtPath:from];
    NSLog(@"%@",subPaths);
//    4.遍历所有文件，然后执行剪切操作
    dispatch_apply(subPaths.count, dispatch_get_global_queue(0, 0), ^(size_t i) {
        //        拼接文件的全路径
        //        NSString *fullPath = [from stringByAppendingString:subPaths[i]];//少一个斜 杠
        NSString *fullPath = [from stringByAppendingPathComponent:subPaths[i]];
        NSString *toFullPath = [to stringByAppendingPathComponent:subPaths[i]];
        //        执行剪切操作
        [[NSFileManager defaultManager] moveItemAtPath:fullPath toPath:toFullPath error:nil];
    });
}
#pragma mark------GCD队列组
-(void)queueArrs
{
//    创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    创建队列组
    dispatch_group_t group = dispatch_group_create();
//    异步函数
    dispatch_group_async(group, queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    
//    1.拦截通知 队列组任务都执行完毕的时候 就会回调下边的方法  q:该方法是阻塞的吗？不是，内部本身是异步
    dispatch_group_notify(group, queue, ^{
        NSLog(@"------dispatch_group_notify-----");
    });
//    2.拦截通知 DISPATCH_TIME_FOREVER:队列组中所有的任务都执行完毕后执行 此方法是阻塞的。
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    //在这个方法后边的异步任务会被纳入到队列组的监听范围，进入群组
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
//        离开群组
        dispatch_group_leave(group);
    });
}
-(void)group3
{
//    1.下载图片1 开子线程
//    2.下载图片2 开子线程
//    3.合成图片并显示 开子线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
    });
    
}
#pragma mark------NSOperation
-(void)operationTest
{
//    创建操作，封装任务
    //object前面方法需要接受的参数 nil
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(operation1) object:nil];
    
//    创建队列  默认情况下，
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    //添加操作到队列中
    [queue addOperation:op1];  //内部已经调用了 启动方法。
    //启动执行 操作
//    [op1 start];
}
-(void)operation1
{
    NSLog(@"-------%@",[NSThread currentThread]);
}
-(void)blockOperation
{
//    创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
       NSLog(@"block1-------%@",[NSThread currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"block2-------%@",[NSThread currentThread]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"block3-------%@",[NSThread currentThread]);
    }];
//    追加任务  如果一个操作中的任务数量大于1，那么会开启子线程并发执行任务。
    [op3 addExecutionBlock:^{
        NSLog(@"block3+1-------%@",[NSThread currentThread]);
    }];
//    启动
    [op1 start];
    [op2 start];
    [op3 start];
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
