//
//  Block1ViewController.m
//  Accumulate
//
//  Created by sanjingrihua on 2018/4/10.
//  Copyright © 2018年 sanjingrihua. All rights reserved.
//

#import "Block1ViewController.h"

@interface Block1ViewController ()

@end

@implementation Block1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}
- (void)blockTestStr{
    //__block
    NSString *str1 = @"llq";
    NSLog(@"str1对象的内存地址：%p\nstr1指针的内存地址：%x",str1,&str1);
    void (^blockStr)(void) = ^{
        //        str1 = @"jly";
        NSLog(@"%@",str1);
        NSLog(@"str1对象的内存地址：%p\nstr1指针的内存地址：%x",str1,&str1);
    };
    NSLog(@"str1对象的内存地址：%p\nstr1指针的内存地址：%x",str1,&str1);
    //被__block修饰过的变量 在 block 内部的会被copy到堆区
    //不被任何修饰的变量
    blockStr();
}
- (void)blockTest{
    //    NSProxy
    int a = 10;
    NSLog(@"-------a:%p",&a);
    void (^block)(void) = ^{
        NSLog(@"%d",a);
        NSLog(@"-------中a:%p",&a);
        NSLog(@"block");
    };
    //block分类 NSGlobalBlock NSMallocBlock NSStackBlock
    block();
    NSLog(@"----%@",block);
    NSLog(@"+++%@",^{NSLog(@"%d",a);});
    //    __block修饰后，在block中能把观察到的变量由栈区copy到堆区
    __block int b = 10;
    NSLog(@"前%p",&b);
    void (^blockb)(void) = ^{
        NSLog(@"中%p",&b);
        NSLog(@"block");
    };
    blockb();
    NSLog(@"后%p",&b);
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
