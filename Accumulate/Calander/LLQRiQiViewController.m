//
//  LLQRiQiViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 16/11/11.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import "LLQRiQiViewController.h"
#import "Datetime.h"
#define ScreenWith [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define lbW      (ScreenWith-10)/7
@interface LLQRiQiViewController ()
{
    NSArray             *dayArray;
    NSArray             *lunarDayArray;
    
    UILabel             *dateLable;
    UIImageView         *touchImgV;
    int                 lastLbTag,currentCalender;
    UIImageView         *todayBgImgV;
    
    UILabel             *titleLb ;//时间
}
@end

@implementation LLQRiQiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _calendarArr=[[NSArray alloc]init];

    _strYear = [[Datetime GetYear] intValue];
    _strMonth = [[Datetime GetMonth] intValue];
    dayArray = [Datetime GetDayArrayByYear:_strYear andMonth:_strMonth];
    lunarDayArray = [Datetime GetLunarDayArrayByYear:_strYear andMonth:_strMonth];
    
    [self initView];
}
- (void)initView {
    //    self.view.backgroundColor=bgColor;
    //日历tableView
    _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWith, ScreenWith+20) style:UITableViewStyleGrouped];
    _myTableView.delegate=self;
    _myTableView.dataSource=self;
    _myTableView.backgroundColor = [UIColor clearColor];
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.sectionFooterHeight = 0;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.rowHeight=230;
    _myTableView.scrollEnabled=NO;
    [self.view addSubview:_myTableView];
    // _myTableView.editing=YES;
    
}
#pragma mark------datasource
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
        _calendarView.backgroundColor = [UIColor whiteColor];
        _calendarView.frame=CGRectMake(0, 0, ScreenWith, 230);
        //            _calendarView.backgroundColor=Cffffff;
        [cell.contentView addSubview:_calendarView];
        
        
        [self AddDaybuttenToCalendarWatch];
        [self AddHandleSwipe];
        return cell;
    }
    return cell;
}
#pragma mark - UITableViewDataSource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    timeV=[[UIView alloc]init];
    [self.view addSubview:timeV];
    if (section == 0) {
        timeV.frame = CGRectMake(0, 8, ScreenWith, 40+39+25+8);
        
        timeV.backgroundColor = [UIColor whiteColor];
        [self addTwoBtn];
        [self AddTimeLableToCalendarView];
        [self AddWeekLableToCalendarWatch];
    }else{
        timeV.backgroundColor = [UIColor clearColor];
        timeV.frame = CGRectMake(0, 0, ScreenWith, 9);
    }
    
    return timeV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0?40+39+25+8:9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *bgView=[[UIView alloc]init];
    bgView.backgroundColor=[UIColor whiteColor];
    
    UIButton *confirmBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame=CGRectMake(8, 8, ScreenWith-8*2, 30);
    confirmBtn.backgroundColor=[UIColor blueColor];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [bgView addSubview:confirmBtn];
    
    return bgView;
}
//向日历中添加指定月份的日历butten
- (void)AddDaybuttenToCalendarWatch {
    for (int i = 0; i < 42; i++) {
        
        UIButton * butten;
        if (butten == nil) {
            butten = [UIButton buttonWithType:UIButtonTypeCustom];
            
        }
        butten.userInteractionEnabled = YES;
        butten.frame = CGRectMake(5+(i%7)*lbW, 4+(i/7)*40, lbW, 40);
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
-(void)addTwoBtn
{
    for (int i=0; i<2; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(8+ScreenWith/2*i, 8, (ScreenWith-8*4)/2, 30);
        [btn setTitle:@"2016-11-01" forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor orangeColor];
        [timeV addSubview:btn];
    }
}
////添加中间的时间标题
-(void)AddTimeLableToCalendarView{
    
    //2016年1月
    [titleLb removeFromSuperview];
    titleLb = [[UILabel alloc] initWithFrame:CGRectMake(120, 8*2+30,ScreenWith-240, 19)];
    //    titleLb.backgroundColor = [UIColor yellowColor];
    titleLb.backgroundColor = [UIColor clearColor];
    titleLb.font = [UIFont systemFontOfSize:15];
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.userInteractionEnabled = NO;
    //    titleLb.textColor=C333333;
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0,ScreenWith-240, 19);
//    btn.backgroundColor = [UIColor orangeColor];
//    [titleLb addSubview:btn];
    
    if (_strMonth < 10) {
        titleLb.text = [NSString stringWithFormat:@"%d年  %d月",_strYear,_strMonth];
    }else titleLb.text = [NSString stringWithFormat:@"%d年%d月",_strYear,_strMonth];
    
    titleLb.hidden = NO;
    titleLb.tag = 2001;
    titleLb.adjustsFontSizeToFitWidth = YES;
    [timeV addSubview:titleLb];
}

//向日历中添加星期标号（周日到周六）
-(void)AddWeekLableToCalendarWatch{
    NSMutableArray* array = [[NSMutableArray alloc]initWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    for (int i = 0; i < 7; i++) {
        UILabel* lable = [[UILabel alloc]init];
        lable.text = [NSString stringWithString:array[i]];
        
        //        lable.textColor =Cadadad;
        lable.font=[UIFont systemFontOfSize:15.0];
        lable.frame = CGRectMake(5+i*lbW,40+39+8, lbW, 25);
        lable.adjustsFontSizeToFitWidth = YES;
        lable.textAlignment = NSTextAlignmentCenter;
        [timeV addSubview:lable];
        
    }
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
    dayArray = nil,lunarDayArray = nil;
    dayArray = [Datetime GetDayArrayByYear:_strYear andMonth:_strMonth];
    lunarDayArray =
    [Datetime GetLunarDayArrayByYear:_strYear andMonth:_strMonth];
    [self reloadDaybuttenToCalendarWatch];
    [self AddTimeLableToCalendarView];
}
-(void)reloadDaybuttenToCalendarWatch{
    for (int i = 0; i < 42; i++)
        [[self.view viewWithTag:200+i] removeFromSuperview];
    [self AddDaybuttenToCalendarWatch];
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
-(void)buttenTouchUpInsideAction:(UIButton*)btn
{
    NSLog(@"%@",btn);
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
