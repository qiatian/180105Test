//
//  LLQTicketViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 16/12/5.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
// 互斥锁 解决多线程安全问题

#import "LLQTicketViewController.h"

@interface LLQTicketViewController ()
{
    int tickets;
    int count;
    NSThread *ticketsThreadone;
    NSThread *ticketsThreadtwo;
    NSCondition *ticketsCondition;
    NSLock *theLock;
}
@property(nonatomic,strong)NSThread *threadA;
@property(nonatomic,strong)NSThread *threadB;
@property(nonatomic,strong)NSThread *threadC;
@property(nonatomic,assign)NSInteger totalCount;//总票数
@end

@implementation LLQTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tickets=100;
    count=0;
    theLock=[[NSLock alloc]init];
    //锁对象
    ticketsCondition=[[NSCondition alloc]init];
    ticketsThreadone=[[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    [ticketsThreadone setName:@"Thread-1"];
    [ticketsThreadone start];
    
    ticketsThreadtwo = [[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    [ticketsThreadtwo setName:@"Thread-2"];
    [ticketsThreadtwo start];
    
}
-(void)run
{
    //互斥锁 注意：枷锁位置，枷锁条件 多线程访问同一个资源
    @synchronized (self) {
        
    }
    while (TRUE) {
        //上锁
        //    [ticketsCondition lock];
        [theLock lock];
        if (tickets>=0) {
            [NSThread sleepForTimeInterval:0.09];
            count=100-tickets;
            NSLog(@"当前票数是：%d,售出:%d,线程名：%@",tickets,count,[NSThread currentThread]);
            tickets--;
        }
        else{
            break;
        }
        [theLock unlock];
//        [ticketsCondition unlock];
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //设置总票数
    self.totalCount = 100;
    self.threadA = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.threadB = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.threadC = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
    
    self.threadA.name = @"售票员A";
    self.threadB.name = @"售票员B";
    self.threadC.name = @"售票员C";
    
    //启动线程
    [self.threadA start];
    [self.threadB start];
    [self.threadC start];
}
-(void)saleTicket{
    
    while (1) {
        //锁 必须是全局唯一的  注意：加锁的位置；加锁的前提条件：多线程访问同一块资源；加锁是需要付出代价的：需要耗费性能；加锁的结果：线程同步
        @synchronized(self){
            NSInteger count = self.totalCount;
            if (count>0) {
                
                //让代码执行时间长一点
                for (NSInteger i = 0; i<100000; i++) {
                }
                
                self.totalCount = count - 1;
                //卖出去一张票
            }else{
                NSLog(@"买不到票了。");
                //退出循环
                break;
            }
        }
        
    }
    
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
