//
//  CalenderViewController.m
//  BackMarkApp
//
//  Created by 力波科技 on 16/1/26.
//  Copyright © 2016年 力波科技. All rights reserved.
//

#import "CalenderViewController.h"
#import "Datetime.h"

#define lbW      (320-10)/7
#define ScreenWith [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface CalenderViewController ()<UIAlertViewDelegate>
{
    UILabel             *label1;
    UILabel             *label2;
    UIView              *lineView;
    NSArray             *dayArray;
    NSArray             *lunarDayArray;
    
    UILabel             *titleLb ;//时间
    UIImageView         *todayBgImgV;
    int                 lastLbTag,currentCalender;
    UIImageView         *touchImgV;
//    OnePlanBaseClass    *onePlanModel;
    UILabel             *dateLable;
    NSString            *uid,*cType;
    UIScrollView        *calenderScroll;
//    OnePlanJson         *deleModel;
    
    
}

@end

@implementation CalenderViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
//    [MobClick endLogPageView:@"calender"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    static int num=1;
//    uid = [LoginData sharedLoginData].userId;

//    [MobClick beginLogPageView:@"calender"];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    NSDate *nowdate=[NSDate date];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr=[dateFormatter stringFromDate:nowdate];
    NSLog(@"num:%d  %@",num,dateStr);
    
    if (num==1) {
//        [USER_D setObject:dateStr forKey:@"selectDay"];
        num=2;
    }
       
//    [USER_D setObject:dateStr forKey:@"todayDate"];
//    [LoginData sharedLoginData];
    BOOL isLogin;
    if (isLogin) {
        cType = @"login";

        [self senderOrderSuccess];
        [self senderOnePlanSuccess];
    }else{
        cType = @"exit";
        
        [self senderOrderSuccess];
        [self senderOnePlanSuccess];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _calendarArr=[[NSArray alloc]init];
    [self initNav];
    _strYear = [[Datetime GetYear] intValue];
    _strMonth = [[Datetime GetMonth] intValue];
    dayArray = [Datetime GetDayArrayByYear:_strYear andMonth:_strMonth];
    lunarDayArray = [Datetime GetLunarDayArrayByYear:_strYear andMonth:_strMonth];
    
    [self initView];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [PublicClass loading];
//        
//    });
}

- (void)initNav {
    
//    self.navBar.titleLabel.text = NSLocalizedString(@"calenderTitle", nil);
//    
//    self.navBar.backBtn.hidden = NO;
//    self.navBar.backBtn.frame = CGRectMake(0, 20, 70, 44);
//    self.navBar.backBtn.titleLabel.font = FontSize15;
//    [self.navBar.backBtn setImage:[UIImage imageNamed:@"ic_nav_bill"] forState:UIControlStateNormal];
////    [PublicClass loadLabelWithPointX:self.navBar.backBtn.sd_width WithPointY:CGRectGetMinY(self.navBar.backBtn.frame) WithWidth:30 WithHeight:CGRectGetHeight(self.navBar.backBtn.frame) WithTitle:NSLocalizedString(@"billLb", nil) WithColor:C848689 WithFontSize:15 WithView:self.navBar];
//    
//    self.navBar.rightBtn.hidden = NO;
////    [self.navBar.rightBtn setImage:[UIImage imageNamed:@"ic_nav_increase"] forState:UIControlStateNormal];
//    [self.navBar.backBtn setTitleColor:C333333 forState:UIControlStateNormal];
//    [self.navBar.backBtn setTitle:NSLocalizedString(@"billLb", nil) forState:UIControlStateNormal];
//    self.navBar.backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);

    
}

//请求本月订单
-(void)senderOrderSuccess
{
    NSString *dateStr;
    if (_strMonth < 10)
    {
        dateStr=[NSString stringWithFormat:@"%d-0%d",_strYear,_strMonth];
        
    }else
    {
        dateStr=[NSString stringWithFormat:@"%d-%d",_strYear,_strMonth];
    }
    //[USER_D objectForKey:@"userId"]
    
    if (![cType isEqualToString:@"exit"]) {
//        [PublicClass loadingWithMsg:@"正在查询预约信息"];
 
    }
    
    NSDictionary *dic;
//    if ([LoginData sharedLoginData].isLogined)  {
//        dic=@{@"uid":uid==nil?@"":uid,@"time":dateStr};
//
//    }else{
//        dic=@{@"time":dateStr};
//
//    }
//    
//    [CarNetWorkingManger PostJSONWithUrl:[NSString stringWithFormat:@"%@selectCalendar?",requestUrl] parameters:dic success:^(NSDictionary *jsonDic) {
//        NSLog(@"selectCalendar%@",jsonDic);
//        [PublicClass hideLoading];
//        _calendarArr=[jsonDic objectForKey:@"json"];
//           [_myTableView reloadData];
//        
//        
//    } fail:^{
////        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
////        [PublicClass alertWriteWithMsg:@"服务器连接断了"];
//
//    }];
}
//=============//=============////=/日历==/////////////////

////添加中间的时间标题
-(void)AddTimeLableToCalendarView{
    //左按钮
    UIButton *leftImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftImage setImage:[UIImage imageNamed:@"ic_Year selection_left"] forState:UIControlStateNormal];

    [ leftImage addTarget:self action:@selector(rightHandleSwipe:) forControlEvents:UIControlEventTouchUpInside];
    
    [timeV addSubview:leftImage];
    leftImage.frame = CGRectMake(20, (39-19)/2.0+8, 100, 19);
    //右按钮
    UIButton *rightImage = [UIButton buttonWithType:UIButtonTypeCustom];
   
    [rightImage setImage:[UIImage imageNamed:@"ic_Year selection_right"] forState:UIControlStateNormal];
    [rightImage addTarget:self action:@selector(leftHandleSwipe:) forControlEvents:UIControlEventTouchUpInside];
    [timeV addSubview:rightImage];
//    rightImage.backgroundColor = [UIColor redColor];
//    rightImage.frame = CGRectMake(kScreenW-20-100, (39-19)/2.0+8, 100, 19);
    
    //2016年1月
    [titleLb removeFromSuperview];
    titleLb = [[UILabel alloc] initWithFrame:CGRectMake(120, CGRectGetMinY(leftImage.frame)+4,320-240, 19)];
//    titleLb.backgroundColor = [UIColor yellowColor];
    titleLb.backgroundColor = [UIColor clearColor];
    titleLb.font = [UIFont systemFontOfSize:14];
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.userInteractionEnabled = NO;
//    titleLb.textColor=C333333;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0,320-240, 19);
//    btn.backgroundColor = [UIColor orangeColor];
    [titleLb addSubview:btn];
    
    if (_strMonth < 10) {
        titleLb.text = [NSString stringWithFormat:@"%d年  %d月",_strYear,_strMonth];
    }else titleLb.text = [NSString stringWithFormat:@"%d年%d月",_strYear,_strMonth];
    
    titleLb.hidden = NO;
    titleLb.tag = 2001;
    titleLb.adjustsFontSizeToFitWidth = YES;
    [timeV addSubview:titleLb];
    UIView *lineView1=[[UIView alloc]initWithFrame:CGRectMake(0, 8+39-1, [UIScreen mainScreen].bounds.size.width, 1)];
//    lineView1.backgroundColor=Ce7e7e7;
    [timeV addSubview:lineView1];
}

//向日历中添加星期标号（周日到周六）
-(void)AddWeekLableToCalendarWatch{
    NSMutableArray* array = [[NSMutableArray alloc]initWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    for (int i = 0; i < 7; i++) {
        UILabel* lable = [[UILabel alloc]init];
        lable.text = [NSString stringWithString:array[i]];
        
//        lable.textColor =Cadadad;
        lable.font=[UIFont systemFontOfSize:15.0];
        lable.frame = CGRectMake(5+i*8,39+8, 8, 25);
        lable.adjustsFontSizeToFitWidth = YES;
        lable.textAlignment = NSTextAlignmentCenter;
        [timeV addSubview:lable];
        
    }
}

- (NSString *)yearAndMonth {
    NSString *monthStr;
    if (_strMonth < 10)
    {
        monthStr=[NSString stringWithFormat:@"%d-0%d",_strYear,_strMonth];
        
    }else
    {
        monthStr=[NSString stringWithFormat:@"%d-%d",_strYear,_strMonth];
    }
    return monthStr;
    
}

//向日历中添加指定月份的日历butten
- (void)AddDaybuttenToCalendarWatch {
    for (int i = 0; i < 42; i++) {
       
        UIButton * butten;
        if (butten == nil) {
            butten = [UIButton buttonWithType:UIButtonTypeCustom];

        }
        butten.userInteractionEnabled = YES;
        butten.frame = CGRectMake(5+(i%7)*lbW, 4+(i/7)*55, lbW, 55);
        [butten setTag:i+200];
        [butten addTarget:self action:@selector(buttenTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        butten.showsTouchWhenHighlighted = YES;
        //日期label
         dateLable = [[UILabel alloc]init];
        if ( [[NSString stringWithString:dayArray[i]] intValue]<10) {
            dateLable.text =[NSString stringWithFormat:@"0%d",[[NSString stringWithString:dayArray[i]] intValue]];
        }
        else
        {
            dateLable.text=[NSString stringWithString:dayArray[i]];
        }
        
        dateLable.tag=200+i;
        dateLable.backgroundColor = [UIColor clearColor];
        dateLable.frame = CGRectMake(0, 0, lbW, 25);
        dateLable.font=[UIFont systemFontOfSize:17.0];
//        dateLable.textColor=C666666;
        dateLable.textAlignment=NSTextAlignmentCenter;
        //label 里面字体自适应label大小
        dateLable.adjustsFontSizeToFitWidth = YES;
        
        
        for (int i=0; i<_calendarArr.count; i++) {
            if (dateLable.text.intValue==[[_calendarArr[i] objectForKey:@"day"] intValue]) {
                //装饰label
                UILabel* lurLable = [[UILabel alloc]init];
                NSString *str;
                if([[_calendarArr[i]objectForKey:@"name"] isEqual:[NSNull null]])
                {
                    str = @"";
                }else{
                    str = [_calendarArr[i]objectForKey:@"name"];
                }
                lurLable.backgroundColor = [UIColor clearColor];
                lurLable.frame = CGRectMake(4, 29, lbW-4, 15);
                lurLable.text = str;
                lurLable.font=[UIFont systemFontOfSize:8.0];
//                lurLable.textColor=Cf25353;
                lurLable.textAlignment=NSTextAlignmentCenter;
                lurLable.layer.masksToBounds=YES;
                lurLable.layer.cornerRadius=3;
                lurLable.layer.borderWidth = 1.0f;
//                lurLable.layer.borderColor = Cf25353.CGColor;
                lurLable.adjustsFontSizeToFitWidth = YES;
                [butten addSubview:lurLable];
                if ([[_calendarArr[i] objectForKey:@"type"]intValue] ==1) {
                    UIImageView *smallImgV=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dateLable.frame)/2-3.5, 50, 7, 3.5)];
                    smallImgV.image=[UIImage imageNamed:@"ic_date_triangle_down"];
                    [butten addSubview:smallImgV];
                    }
                break;
                
            }
        }
        
        NSString *dateStr=[NSString stringWithFormat:@"%@-%@",[self yearAndMonth],dateLable.text];
       
        if([dateStr isEqualToString:@"selectDay"])
        {
            
            touchImgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cal_selected"]];
            touchImgV.frame=CGRectMake((lbW-26)/2, 0, 26, 26);
            touchImgV.userInteractionEnabled = YES;
            [butten addSubview:touchImgV];
            lastLbTag=(int)dateLable.tag;
            if ([dateStr isEqualToString:@"todayDate"]) {

                touchImgV.image=[UIImage imageNamed:@"current_red"];
                dateLable.textColor=[UIColor whiteColor];
                
            }
            
        }

       //今天
        if (([[Datetime GetDay] intValue]== [dayArray[i] intValue])&&(_strMonth == [[Datetime GetMonth] intValue])&&(_strYear == [[Datetime GetYear] intValue])) {
//      todayBgImgV=[PublicClass loadImageViewWithPontX:lbW/2- 13 WithPointY:0 WithWidth:26 WithHeight:26 WithImg:@"current_red" WithPlaceStr:@"current_red" WithView:butten];
            if (![@"selectDay" isEqualToString:@"todayDate"]) {
                todayBgImgV.image=[UIImage imageNamed:@"current_gray"];
            }
            

       }
       
     [butten addSubview:dateLable];
        if (![dateLable.text isEqualToString:@"00"]) {
            
            [_calendarView addSubview:butten];
        }
        
        
        
    }
    
   
    
}
-(void)reloadDaybuttenToCalendarWatch{
    for (int i = 0; i < 42; i++)
        [[self.view viewWithTag:200+i] removeFromSuperview];
    [self AddDaybuttenToCalendarWatch];
}

////日期点击事件
-(void)buttenTouchUpInsideAction:(id)sender{
    return;
//    if ([LoginData sharedLoginData].isLogined) {
//        NSInteger t = [sender tag]-200;
//        dayArray = nil,lunarDayArray = nil;
//        dayArray = [Datetime GetDayArrayByYear:_strYear andMonth:_strMonth];
//        lunarDayArray =
//        [Datetime GetLunarDayArrayByYear:_strYear andMonth:_strMonth];
//        UIButton *smallBtn=(UIButton *)sender;//当前点击的button
//        UIButton *buttonLast=(UIButton*)[_calendarView viewWithTag:lastLbTag];//上一个点击的button
//        //记录点击日期
//        NSString *dayStr;
//        if ([dayArray[t] intValue]<10) {
//            dayStr=[NSString stringWithFormat:@"%@-0%d",[self yearAndMonth],[dayArray[t]intValue]];
//        }
//        else
//        {
//            dayStr=[NSString stringWithFormat:@"%@-%d",[self yearAndMonth],[dayArray[t]intValue]];
//        }
//        
//        for (id view in buttonLast.subviews) {
//            
//            if ([view isKindOfClass:[UILabel class]]) {
//                UILabel *lb=(UILabel *)view;
//                //上次点击的Btn
//                if([ [USER_D objectForKey:@"selectDay"] isEqualToString:[USER_D objectForKey:@"todayDate"]]&&lb.tag==buttonLast.tag)
//                {
//                    lb.textColor=C666666;
//                    break;
//                }
//                
//            }
//            
//        }
//        [USER_D setObject:dayStr forKey:@"selectDay"];
//        for (id view in smallBtn.subviews) {
//            if ([view isKindOfClass:[UILabel class]]) {
//                UILabel *lb=(UILabel *)view;
//                
//                if ([dayStr isEqualToString:[USER_D objectForKey:@"todayDate"]]&&lb.tag==smallBtn.tag) {
//                    lb.textColor=[UIColor whiteColor];
//                }
//            }
//        }
//        //本次点击的Btn
//        if ([[USER_D objectForKey:@"selectDay"]isEqualToString:[USER_D objectForKey:@"todayDate"]]) {
//            todayBgImgV.image=[UIImage imageNamed:@"current_red"];
//            
//            
//        }
//        else
//        {
//            todayBgImgV.image=[UIImage imageNamed:@"current_gray"];
//            
//        }
//        
//        [touchImgV removeFromSuperview];
//        UILabel *selectLb=(UILabel *)[sender viewWithTag:smallBtn.tag];
//        touchImgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cal_selected"]];
//        touchImgV.frame=CGRectMake((lbW-26)/2, 0, 26, 26);
//        [selectLb addSubview:touchImgV];
//        lastLbTag=(int)selectLb.tag;
//        [PublicClass loading];
//
//        [self senderOnePlanSuccess];
//    }
//    else
//    {
//        [PublicClass alertWriteWithMsg:@"请先登录"];
//    }
//   
//   
}

//请求某天计划
-(void)senderOnePlanSuccess {
    NSDictionary *dic;
    BOOL isLogin;
    if (isLogin) {
        dic=@{@"uid":uid == nil?@"":uid,@"time":@"selectDay"};
    } else {
        dic=@{@"time":@"selectDay"};
    }
    
//    [CarNetWorkingManger PostJSONWithUrl:[NSString stringWithFormat:@"%@selectOnePlan?",requestUrl] parameters:dic success:^(NSDictionary *jsonDic) {
//        [PublicClass hideLoading];
//       onePlanModel=[[OnePlanBaseClass alloc]initWithDictionary:jsonDic];
//        NSLog(@"onePlanModel===%@",onePlanModel);
//         //一个section刷新
//        
////         NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
////         [_myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//
//        [_myTableView reloadData];
//        
//    } fail:^{
////        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
////        [PublicClass alertWriteWithMsg:@"服务器连接断了"];
//    }];
}

//添加左右滑动手势
-(void)AddHandleSwipe{
    //声明和初始化手势识别器
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftHandleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightHandleSwipe:)];
    //对手势识别器进行属性设定
    [swipeLeft setNumberOfTouchesRequired:1];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setNumberOfTouchesRequired:1];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    //把手势识别器加到view中去
    [_calendarView addGestureRecognizer:swipeLeft];
    [_calendarView addGestureRecognizer:swipeRight];
}
//左滑事件 月份++
- (void)leftHandleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    
    _strMonth = _strMonth+1;
    if(_strMonth == 13){
        _strYear++;_strMonth = 1;
    }
    [self reloadDateForCalendarWatch];
    
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [_myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    
}
//右滑事件 月份--
- (void)rightHandleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    

        _strMonth = _strMonth-1;
        if(_strMonth == 0){
            _strYear--;_strMonth = 12;
        }
        
        [self reloadDateForCalendarWatch];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [_myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    
}

//在CalendarWatch中重新部署数据
- (void)reloadDateForCalendarWatch {
    [self senderOrderSuccess];
    dayArray = nil,lunarDayArray = nil;
    dayArray = [Datetime GetDayArrayByYear:_strYear andMonth:_strMonth];
    lunarDayArray =
    [Datetime GetLunarDayArrayByYear:_strYear andMonth:_strMonth];
//    [self reloadDaybuttenToCalendarWatch];
//    [self AddTimeLableToCalendarView];
}


//=======================///===============////=====================
- (void)initView {
//    self.view.backgroundColor=bgColor;
    //日历tableView
    _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWith, ScreenHeight-64-49) style:UITableViewStyleGrouped];
    _myTableView.delegate=self;
    _myTableView.dataSource=self;
    _myTableView.backgroundColor = [UIColor clearColor];
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.sectionFooterHeight = 0;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
    [_myTableView registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"detailCell"];
   // _myTableView.editing=YES;
    
}

//右键重写
//-(void)rightBtnClick:(UIButton *)btn
//{
//    if([LoginData sharedLoginData].userId)
//    {
//        AddnurturanceViewController *addVC=[AddnurturanceViewController new];
//        addVC.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:addVC animated:YES];
//    }
//    else
//    {
//        UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//        UINavigationController *loginVC = [loginSB instantiateViewControllerWithIdentifier:@"LoginNav"];
//        [self presentViewController:loginVC animated:YES completion:nil];
//
////        [PublicClass alertWriteWithMsg:@"请先登录"];
////        LoginViewController *loginVC = [[LoginViewController alloc]init];
////        loginVC.hidesBottomBarWhenPushed = YES;
////        [self.navigationController pushViewController:loginVC animated:YES];
//    }
//   
//}
// 左键重新
//-(void)back
//{
//    if([LoginData sharedLoginData].userId)
//    {
//        BillViewController *billVC=[BillViewController new];
//        billVC.hidesBottomBarWhenPushed=YES;
//        billVC.timeStr=[self yearAndMonth];
//        [self.navigationController pushViewController:billVC animated:YES];
//    }
//    else
//    {
//        UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//        UINavigationController *loginVC = [loginSB instantiateViewControllerWithIdentifier:@"LoginNav"];
//        [self presentViewController:loginVC animated:YES completion:nil];
//
//        [PublicClass alertWriteWithMsg:@"请先登录"];
//        LoginViewController *loginVC = [[LoginViewController alloc]init];
//        loginVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:loginVC animated:YES];
//    }
//
//    
//}

#pragma mark - UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    timeV=[[UIView alloc]init];
    [self.view addSubview:timeV];
    if (section == 0) {
//        UILabel *pLbale = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 80)];
//        pLbale.backgroundColor = bgColor;
        timeV.frame = CGRectMake(0, 8, ScreenWith, 39+25+8);

        timeV.backgroundColor = [UIColor whiteColor];
        [self AddTimeLableToCalendarView];
        [self AddWeekLableToCalendarWatch];
    }else{
        timeV.backgroundColor = [UIColor clearColor];
        timeV.frame = CGRectMake(0, 0, ScreenWith, 9);
    }
   
    return timeV;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;//+onePlanModel.json.count
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CalendarCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CalendarCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==0) {
            _calendarView=[[UIView alloc]init];
            _calendarView.tag = 1000;
            _calendarView.backgroundColor = [UIColor clearColor];
            _calendarView.frame=CGRectMake(0, 0, ScreenWith, 340);
//            _calendarView.backgroundColor=Cffffff;
            [cell.contentView addSubview:_calendarView];
        [self AddDaybuttenToCalendarWatch];
        [self AddHandleSwipe];
        return cell;
    } else {
//        DetailTableViewCell *detailCell=[tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
//        OnePlanJson *planJsonModel= [onePlanModel.json objectAtIndex:indexPath.section-1];
//        
//        cell.tag = indexPath.section;
//        if (planJsonModel.type==1) {
//            
//            detailCell.addressLb.text=planJsonModel.sname;
//
//            if (planJsonModel.isDelete==1) {
//                detailCell.bespeakLb.text=@"待执行";
//            }else if(planJsonModel.isDelete==2)
//            {
//                detailCell.bespeakLb.text=@"已完成";
//            }else if(planJsonModel.isDelete==4)
//            {
//                detailCell.bespeakLb.text=@"待评估";
//            }else if(planJsonModel.isDelete==5)
//            {
//                detailCell.bespeakLb.text=@"待付订金";
//            }else if(planJsonModel.isDelete==6)
//            {
//                detailCell.bespeakLb.text=@"待付余款";
//            }else if(planJsonModel.isDelete==7)
//            {
//                detailCell.bespeakLb.text=@"待评价";
//            }else if(planJsonModel.isDelete==9 || planJsonModel.isDelete == 8)
//            {
//                detailCell.bespeakLb.text=@"取消订单中";
//            }else if(planJsonModel.isDelete==10){
//                detailCell.bespeakLb.text=@"门店取消中";
//
//            }else{
//                detailCell.bespeakLb.text=@"退款中";
//
//            }
//        }
//        else
//        {
//            detailCell.bespeakLb.text=@"手动添加";
//            detailCell.addressLb.text=planJsonModel.content;
//        }
//        
//        int strlength = (int)planJsonModel.mtime.length;
//        NSString *shiJIanStr=[planJsonModel.mtime substringWithRange:NSMakeRange(5, strlength-8)];
//      
//        detailCell.timeLb.text=shiJIanStr;
//        detailCell.nameLb.text=planJsonModel.name;
//       
//        detailCell.moneyLb.text=[NSString stringWithFormat:@"￥%.2f",planJsonModel.money];
//        return detailCell;
        
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 340;
    } else {
       return 72;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0?39+25+8:9;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    OnePlanJson *planJsonModel= [onePlanModel.json objectAtIndex:indexPath.section-1];
//    if (indexPath.section!=0) {
//        DetailTableViewCell *cell=(DetailTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//        if ([cell.bespeakLb.text isEqualToString:@"手动添加"]) {
//            AddnurturanceViewController *addVC=[AddnurturanceViewController new];
//            addVC.hidesBottomBarWhenPushed=YES;
//            [USER_D setObject:planJsonModel.mtime forKey:@"addCarMessageTime"];
//            addVC.selectStr=planJsonModel.name;
//            addVC.inputStr=planJsonModel.content;
//           
//            addVC.moneyStr=[NSString stringWithFormat:@"%0.2f",planJsonModel.money];
//            addVC.myId=[NSString stringWithFormat:@"%0.f",planJsonModel.mid];
//            addVC.type=2;
//            addVC.bigId=[NSString stringWithFormat:@"%0.f",planJsonModel.jsonIdentifier];
//
//            [self.navigationController pushViewController:addVC animated:YES];
//        }
//        else
//        {
//            OrderDetailViewController *orderVC=[OrderDetailViewController new];
//            orderVC.hidesBottomBarWhenPushed=YES;
//            orderVC.isDelete=planJsonModel.isDelete;
//            orderVC.myId=[NSString stringWithFormat:@"%f",planJsonModel.jsonIdentifier];
//            [self.navigationController pushViewController:orderVC animated:YES];
//        }
//    }
    
    
    
}

#pragma mark -- 编辑
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section!=0)
    {
//        DetailTableViewCell *detailCell=(DetailTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//        if ([detailCell.bespeakLb.text isEqualToString:@"手动添加"])
//        {
//            return UITableViewCellEditingStyleDelete;//手势滑动删除
//        }

        
    }
    return UITableViewCellEditingStyleNone;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
//        NSDictionary *dic=@{@"id":[NSString stringWithFormat:@"%.f",deleModel.jsonIdentifier]};
//        [CarNetWorkingManger PostJSONWithUrl:[NSString stringWithFormat:@"%@deleteManual?",requestUrl] parameters: dic success:^(NSDictionary *jsonDic) {
//            NSString *str=[jsonDic objectForKey:@"message"];
//            [self senderOrderSuccess];
//            [self senderOnePlanSuccess];
//            
//            [PublicClass alertWriteWithMsg:str];
//        } fail:^{
//            
//        }];


    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
//    
//        NSArray *jsonArr=onePlanModel.json;
//        deleModel=[jsonArr objectAtIndex:indexPath.section-1];
//                //方法实现后，默认实现手势滑动删除的方法
//        if (editingStyle!=UITableViewCellEditingStyleDelete) {
//            return ;
//        }
        _myTableView.editing = !_myTableView.editing;
}
@end
