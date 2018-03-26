//
//  ViewController.m
//  Accumulate
//
//  Created by sanjingrihua on 2017/11/20.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "ViewController.h"
#import "LQThread.h"
//socket
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
//保住线程生命周期：只有唯一一个办法，让线程有执行不完的任务  strong只能保住对象生命周期
//主线程对于系统来说，就是一个子线程；
@interface ViewController ()
//@property(nonatomic,strong)LQThread *thread;
//nonatomic 非原子 没有锁 线程不安全 多条线程可以抢夺资源  UI操作只允许主线程操作
@property(nonatomic,assign)BOOL Finished;
//连接socket
@property(nonatomic,assign)int clientSocket;
@end
//CFRunloop图片渲染 优化  渲染太多图片18张  每次runloop循环里面，加载一张图片
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self mainThreadDemo];
//    [self demo2];
    //线程间的通讯  子线程在start之后执行
    NSThread *t = [[NSThread alloc]initWithBlock:^{
        NSLog(@"viewDidLoad---%@",[NSThread currentThread]);
        while (!_Finished) {
            [[NSRunLoop currentRunLoop]runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.0001]];
        }
    }];
    [t start];
//    [NSThread sleepForTimeInterval:1.0];
    NSLog(@"main thread");
    //给子线程添加任务事件 有runloop才有可能处理
    [self performSelector:@selector(otherMethod) onThread:t withObject:nil waitUntilDone:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerMethod2) userInfo:nil repeats:YES];
    
    [self addRunloopObserver];//添加观察者
    
    //Socket
    _clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    [self connectionWithPort:80 addr:"14.215.177.38"];
    //发送数据给百度
    NSString *request = @"GET / HTTP/1.1\n"
    "Host: www.baidu.com\n\n";//baidu.com
    [self sendMsgAndRecv:request];//@"百度 你好"
}
- (void)connectionWithPort:(int)port addr:(const char *)addr{
    
    struct sockaddr_in serverAddr;
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(port);//端口 二进制高位和低位互换20480
    serverAddr.sin_addr.s_addr = inet_addr(addr);
    int connResult = connect(_clientSocket, (const struct sockaddr*)&serverAddr, sizeof(serverAddr));
    if (connResult==0) {
        NSLog(@"连接成功");
    }else{
        NSLog(@"连接失败");
    }
}
- (void)sendMsgAndRecv:(NSString*)sendMsg{
//    NSString *sendMsg = @"hello";
    ssize_t sendLen = send(_clientSocket, sendMsg.UTF8String, strlen(sendMsg.UTF8String), 0);
    NSLog(@"发送了%zd个字节",sendLen);
    //从服务器接受数据 客户端socket;接受内容缓冲区地址；接受内容缓存区长度；接受方式0表示阻塞 必须等待服务器返回数据  返回值：如果成功，则返回读入的字节数，失败到返回的socket_error
    uint8_t buffer[1024];//将空间准备出来
    ssize_t recvLen = recv(_clientSocket, buffer, sizeof(buffer), 0);
    //回调 用 函数指针
    NSLog(@"接收到啦%zd个字节",recvLen);
    if (recvLen<0) {
        return;
    }
    NSData *data = [NSData dataWithBytes:buffer length:recvLen];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    //关闭
    close(_clientSocket);
}
-(void)socketDemo{
    //创建socket domain:协议域 type： socket类型:SOCK_STREAM--TCP  protocol：如果传入0，会自动根据第二个参数，选择合适的协议
    int clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    //连接到服务器 客户端socket 指向数据结构的指针包括目的端口和IP地址  结构体数据长度
    struct sockaddr_in serverAddr;
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(80);//端口 二进制高位和低位互换20480
    serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    int connResult = connect(clientSocket, (const struct sockaddr*)&serverAddr, sizeof(serverAddr));
    if (connResult==0) {
        NSLog(@"连接成功");
    }else{
        NSLog(@"连接失败");
    }
    //发送数据给服务器 客户端socket 发送内容地址； 发送内容长度；发送方式标志一般为0
    NSString *sendMsg = @"hello";
    ssize_t sendLen = send(clientSocket, sendMsg.UTF8String, strlen(sendMsg.UTF8String), 0);
    NSLog(@"发送了%zd个字节",sendLen);
    //从服务器接受数据 客户端socket;接受内容缓冲区地址；接受内容缓存区长度；接受方式0表示阻塞 必须等待服务器返回数据  返回值：如果成功，则返回读入的字节数，失败到返回的socket_error
    uint8_t buffer[1024];//将空间准备出来
    ssize_t recvLen = recv(clientSocket, buffer, sizeof(buffer), 0);
    //回调 用 函数指针
    NSLog(@"接收到啦%zd个字节",recvLen);
    NSData *data = [NSData dataWithBytes:buffer length:recvLen];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    //关闭
    close(clientSocket);
}
-(void)timerMethod2{
    //啥都不干
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _Finished = YES;
    /*干主线程；  不理你； app挂了；  主线程没了，子线程仍然继续*/
    [NSThread exit];
}
-(void)otherMethod{
    NSLog(@"otherMethod---%@",[NSThread currentThread]);
}
-(void)demo2{
    _Finished = NO;
    LQThread *thread = [[LQThread alloc]initWithBlock:^{
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
        //NSRunLoop 子线程
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        
        //开启NSRunLoop循环  很难干掉
        //         [[NSRunLoop currentRunLoop]run];
        
        
        //执行不完的任务
        while (!_Finished) {
            //到事件队列中，取出事件，然后执行
            [[NSRunLoop currentRunLoop]runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.0001]];
            
        }
        NSLog(@"come first");
    }];
    [thread start];
}
-(void)mainThreadDemo{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    //NSRunLoop
    //    [NSRunLoop mainRunLoop] NSDefaultRunLoopMode默认模式  NSRunLoopCommonModes占位（默认&UI）
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
-(void)timerMethod{
    
    if (_Finished) {
        [NSThread exit];//干掉当前线程
    }
    [NSThread sleepForTimeInterval:1.0];
    static int a = 0;
    a++;
    NSLog(@"%dcome in%@",a,[NSThread currentThread]);
}
//添加runloop观察者
-(void)addRunloopObserver{
    //拿到runloop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    
    //定义一个上下文
    CFRunLoopObserverContext context = {0,(__bridge void*)self,&CFRetain,&CFRelease,NULL};
    //创建观察者
    CFRunLoopObserverRef runloopObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, 0, &callBack, &context);
    CFRunLoopAddObserver(runloop, runloopObserver, kCFRunLoopDefaultMode);
}
void callBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    ViewController *vc = (__bridge ViewController*)info;
    
//    NSLog(@"来了吗%@",vc);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
