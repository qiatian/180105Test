//
//  LLQVedioViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 17/2/24.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "LLQVedioViewController.h"

@interface LLQVedioViewController ()

@end

@implementation LLQVedioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",NSStringFromCGRect([UIScreen mainScreen].bounds));
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
