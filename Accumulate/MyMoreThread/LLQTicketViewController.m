//
//  LLQTicketViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 16/12/5.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

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
