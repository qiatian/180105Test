//
//  BasisViewController.m
//  Accumulate
//
//  Created by sanjingrihua on 2018/3/21.
//  Copyright © 2018年 sanjingrihua. All rights reserved.
//

#import "BasisViewController.h"

@interface BasisViewController ()
@property(nonatomic,copy) NSString *name;
@property(nonatomic,strong) NSString *name1;

@property(nonatomic,strong) NSString *strongStr;
@property(nonatomic,weak) NSString *weakStr;
@end

@implementation BasisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",_name);
    NSMutableString *str = [[NSMutableString alloc] initWithString:@"test,what happend"];
    self.name = str;
    self.name1 = str;
    NSLog(@"name的%p----name1的%p-----str的%p",self.name,self.name1,str);
    
    self.strongStr = @"StringTest";
    self.weakStr = self.strongStr;
    self.strongStr = nil;
    NSLog(@"strongStr=%@,weakStr=%@,strongStr=%p,weakStr=%p",self.strongStr,self.weakStr,self.strongStr,self.weakStr);
}
- (void)test{
    int a = 10;
    __block int b = 20;
    NSString *str = @"123";
    __block NSString *blockStr = str;
    NSString *strongStr = @"456";
    __weak NSString *weakStr = @"789";
    
    //定义带参数的block
    void (^blockTest)(int) = ^(int c){
        int d = a + b +c;
        NSLog(@"d=%d,strongStr=%@,blockStr=%@,weakStr=%@",d,strongStr,blockStr,weakStr);
    };
    a = 20;
    b = 40;
    blockTest(30);
    
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
