//
//  LLQRiQiViewController.h
//  Accumulation
//
//  Created by sanjingrihua on 16/11/11.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLQRiQiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
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
