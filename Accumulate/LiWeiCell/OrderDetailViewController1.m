//
//  OrderDetailViewController.m
//  Farmers
//
//  Created by 览山晓 on 16/10/28.
//  Copyright © 2016年 Farmers. All rights reserved.

//  所有的订单详情

#import "OrderDetailViewController1.h"
//#import "EvaluateViewController.h"
//#import "LogisticsInformationController.h"
#import "OderDetailCell.h"
#import "SecondTableViewCell.h"
#import "ThreeTableViewCell.h"

static NSString *const oderDetailCellID = @"OderDetailCell";
static NSString *const secondCellID = @"SecondTableViewCell";
static NSString *const threeCellID = @"ThreeTableViewCell";

@interface OrderDetailViewController1 () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak, nullable) UITableView *tableView;
@end

@implementation OrderDetailViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.titleLabel.text = @"订单详情";
//    [self setNavigationTitle:@"订单详情"];
    // 设置UI
    [self setupUI];

}

- (void)setupUI {
    if (!self.tableView) {
//        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
//        tableView.backgroundColor = RGBColor(241, 241, 241) ;
//        tableView.showsVerticalScrollIndicator = NO;
//        tableView.dataSource = self;
//        tableView.delegate = self;
//        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//        [self.view addSubview:tableView];
//        self.tableView = tableView;
        
        // 注册Cell
        [self.tableView registerClass:[OderDetailCell class] forCellReuseIdentifier:oderDetailCellID];
        [self.tableView registerClass:[SecondTableViewCell class] forCellReuseIdentifier:secondCellID];
        [self.tableView registerClass:[ThreeTableViewCell class] forCellReuseIdentifier:threeCellID];
    }
}

#pragma mark - UITableViewDataSource 、UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
//    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        OderDetailCell *oderCell = [tableView dequeueReusableCellWithIdentifier:oderDetailCellID forIndexPath:indexPath];
        oderCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        oderCell.backgroundColor=MainColor;
        
        return oderCell;
    }
    else if (indexPath.section == 1) {
        SecondTableViewCell *secondCell = [tableView dequeueReusableCellWithIdentifier:secondCellID forIndexPath:indexPath];
        secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        secondCell.backgroundColor=YColor;
        
        return secondCell;
    }
    else  {
        ThreeTableViewCell *threeCell = [tableView dequeueReusableCellWithIdentifier:threeCellID forIndexPath:indexPath];
        threeCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        threeCell.backgroundColor=[UIColor purpleColor];
        return threeCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    EvaluateViewController *evaluate = [[EvaluateViewController alloc] init];
//    evaluate.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:evaluate animated:YES];
    
//    LogisticsInformationController *delivery = [[LogisticsInformationController alloc] init];
//    delivery.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:delivery animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 110;
    } else if (indexPath.section == 1) {
        return 140;
    } else {
        return 150;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 13;
}
@end
