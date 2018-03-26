//
//  SocketViewController.m
//  Accumulate
//
//  Created by sanjingrihua on 2018/3/22.
//  Copyright © 2018年 sanjingrihua. All rights reserved.
// 因为分布式，可能不同地方百度地址不一样
//网络&&安全  数据安全 金融 网络通讯 安全防范
//https 发送数据上做手脚
//base64编码方案 可以将任意的二进制数据进行编码，编码成为只有65个字符的文本文件0-9，a-z，A-Z；

#import "SocketViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@interface SocketViewController ()
@property(nonatomic,assign)int clientSocket;
@end

@implementation SocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建socket
    _clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    //做http访问
    [self connectionWithPort:80 addr:"119.75.216.20"];
    
    //发送数据 http协议
    NSString *requestStr = @"GET / HTTP/1.1\nHost: www.baidu.com\n\n";
    [self sendAndRecv:requestStr];//@"是百度么？？？"
}
- (void)connectionWithPort:(int)port addr:(const char *)addr{
    
    struct sockaddr_in serverAddr;
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(port);//20480网络传输上的端口和日常不一样
    serverAddr.sin_addr.s_addr = inet_addr(addr);//地址
    
    //连接服务器
    int connResult = connect(_clientSocket, (const struct sockaddr *)&serverAddr, sizeof(serverAddr));
    if (connResult == 0) {
        NSLog(@"连接成功!!");
    }else{
        NSLog(@"连接失败%d",connResult);
        return;
    }
}
- (void)sendAndRecv:(NSString *)sendMsg{
    //发送
    size_t sendLen = send(_clientSocket, sendMsg.UTF8String, strlen(sendMsg.UTF8String), 0);
    NSLog(@"发送了%zd字节数据",sendLen);
    
    //接收
    uint8_t buffer[1024];
    ssize_t recvLen = recv(_clientSocket, buffer, sizeof(buffer), 0);
    NSLog(@"接收了%zd字节数据",recvLen);
    if (recvLen < 0) {
        return;
    }
    NSData *data = [NSData dataWithBytes:buffer length:recvLen];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",dataStr);
    
    //关闭
    close(_clientSocket);
}
- (void)socketDemo{
    //80端口默认开启 阿帕奇服务器 打开终端 nc -lk 12345
    
    //创建socket 参数1domain协议域AF_INET代表ipv4  参数2类型TCP/UDP 参数3传入0根据第二个参数，选择合适的协议
    int clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    //连接到服务器 参数1客户端socket 参数2指向数据结构的sockaddr的指针，其中包括IP和端口  参数3结构体数据长度
    struct sockaddr_in serverAddr;
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(80);//20480网络传输上的端口和日常不一样
    serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");//地址
    int connResult = connect(clientSocket, (const struct sockaddr *)&serverAddr, sizeof(serverAddr));
    if (connResult == 0) {
        NSLog(@"连接成功");
    }else{
        NSLog(@"连接失败%d",connResult);
        return;
    }
    //发送数据到服务器 参数1客户端socket 参数2发送内容地址 参数3内容长度 参数4发送方式标志，一般为0  返回值如果成功返回发送的字节数，失败返回SOCKET_ERROR
    NSString *sendMsg = @"Hello";
    ssize_t sendLen = send(clientSocket, sendMsg.UTF8String, strlen(sendMsg.UTF8String), 0);
    NSLog(@"发送了%zd字节数据",sendLen);
    //从服务器接收数据 参数1客户端socket 参数2接收内容缓冲区地址 参数3接收内容缓存区长度 参数4接收方式，0表示阻塞，必须等待返回数据  返回值如果成功返回发送的字节数，失败返回SOCKET_ERROR
    uint8_t buffer[1024];//将空间准备出来
    //阻塞式
    ssize_t recvLen = recv(clientSocket, buffer, sizeof(buffer), 0);
    //回调 用函数指针
    //循环拿数据
    NSData *data = [NSData dataWithBytes:buffer length:recvLen];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",dataStr);
    
    //关闭socket
    close(clientSocket);
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
