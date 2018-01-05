//
//  CalenderViewController.h
//  BackMarkApp
//
//  Created by 力波科技 on 16/1/26.
//  Copyright © 2016年 力波科技. All rights reserved.
//

//#import "MyBaseViewController.h"
//#import "OnePlanJson.h"
#import <UIKit/UIKit.h>

@interface CalenderViewController :UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    UIView *timeV;//2016年1月
   
}
@property(nonatomic,strong)UITableView *myTableView;

@property (nonatomic, strong)NSMutableArray *seletedDays;//选择的日期
@property(nonatomic,strong) UIView *calendarView;//日历View
@property(nonatomic,strong)NSArray *calendarArr;//有小label的个数
@property(nonatomic,assign)int strMonth;//月
@property(nonatomic,assign)int strYear;//年

@end
