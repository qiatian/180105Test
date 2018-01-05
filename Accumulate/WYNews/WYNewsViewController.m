//
//  WYNewsViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 17/5/31.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "WYNewsViewController.h"

@interface WYNewsViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIScrollView *titleSV;
@property(nonatomic,weak)UIScrollView *contentSV;
@property(nonatomic,weak)UIButton *selectBtn;
@property(nonatomic,strong)NSMutableArray *titleBtns;
@property(nonatomic,assign)BOOL isInitialize;

@property(nonatomic,weak)id observe;
@end

@implementation WYNewsViewController
-(NSMutableArray*)titleBtns
{
    if (_titleBtns ==nil) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationItem.title = @"网易新闻";
    
    self.view.backgroundColor = [UIColor whiteColor];
    //1.添加标题滚动视图
    [self setupTitleScrollView];

//    2.添加内容滚动视图
    [self setupContentScrollView];
    
    //5.处理标题点击事件
    //6.处理内容滚动视图滚动
    //7.选中标题居中
    //queue:nil发布通知的线程中执行 不用设置观察者，需要移除
    _observe = [[NSNotificationCenter defaultCenter] addObserverForName:@"" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
    }];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       //异步监听
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reciveNote:) name:@"" object:nil];
    });
    //主线程 监听 异步：发出通知
    
    [self getMainThread];
}
-(void)getMainThread
{
    NSThread *mainThread = [NSThread mainThread];
    NSLog(@"-----%@",mainThread);
    //获得当前线程
    NSThread *currentThread = [NSThread currentThread];
    NSLog(@"+++++%@",currentThread);
    
    //判断主线程  number ＝＝ 1
//    类方法
    BOOL isMainThread = [NSThread isMainThread];
//    对象方法
    BOOL isMainThreadQ = [currentThread isMainThread];
    
    NSLog(@"=====%d    %d",isMainThread,isMainThreadQ);
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"note" object:nil];
}
-(void)test1{
}
-(void)test2{
}
-(void)reciveNote:(NSNotification*)noti
{
    NSLog(@"%@",[NSThread currentThread]);
    dispatch_sync(dispatch_get_main_queue(), ^{
        
    });
}
-(void)viewWillAppear:(BOOL)animated//在viewDidLoad之后执行
{
    [super viewWillAppear:animated];
    if (_isInitialize == NO) {
        self.contentSV.contentSize = CGSizeMake(ScreenW*self.childViewControllers.count, 0);
        //4.设置所有标题
        [self setupAllTitle];
        _isInitialize = YES;
    }
    
}
#pragma mark-----设置所有标题按钮
-(void)setupAllTitle
{
    //内容展示不上去。。bug:代码一样。
    //    ios7以后，导航控制器中scollView顶部会添加64的额外滚动区域
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //添加所有标题按钮
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW=100;
    CGFloat btnH=self.titleSV.bounds.size.height;
    CGFloat btnX=0;
    for (int i=0; i<count; i++) {
        btnX = i*btnW;
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.frame = CGRectMake(btnX, 0, btnW, btnH);
        UIViewController *vc = self.childViewControllers[i];
        [titleBtn setTitle:vc.title forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        titleBtn.tag = i;
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //把标题按钮保存到对应数组
        [self.titleBtns addObject:titleBtn];
        if (i==0) {
            [self titleBtnClick:titleBtn];
        }
        [self.titleSV addSubview:titleBtn];
        
    }
    
    _titleSV.contentSize = CGSizeMake(btnW*count, 0);
    self.titleSV.showsHorizontalScrollIndicator = NO;
}
#pragma mark-----添加一个子控制器的view
-(void)setupOneViewController:(NSInteger )i
{
    UIViewController *vc = self.childViewControllers[i];
    if (vc.view.superview) {//viewIfLoaded iOS9
        return;
    }
    CGFloat x = i*[UIScreen mainScreen].bounds.size.width;
    vc.view.frame = CGRectMake(x, 0, [UIScreen mainScreen].bounds.size.width, self.contentSV.bounds.size.height);
    [self.contentSV addSubview:vc.view];
}
-(void)titleBtnClick:(UIButton*)btn
{
    NSInteger i = btn.tag;
//    标题颜色 变化 红色
    [self selButton:btn];
//    添加对应子控制器view到占位视图
    [self setupOneViewController:i];
    CGFloat x = i*[UIScreen mainScreen].bounds.size.width;
//    内容滚动视图滚动到对应位置
    self.contentSV.contentOffset = CGPointMake(x, 0);
}
#pragma mark-----只要一滚动 就需要字体渐变
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    字体缩放 1.缩放比例 2.缩放哪两个按钮
    //获取左边按钮
    NSInteger leftI = scrollView.contentOffset.x/ScreenW;
    NSInteger rightI = leftI + 1;
    UIButton *leftBtn = self.titleBtns[leftI];
//    获取右边按钮
    NSInteger count = self.titleBtns.count;
    UIButton *rightBtn;
    if (rightI < count ) {
        rightBtn = self.titleBtns[rightI];
    }
    //0～1 》》》1～1.3
    CGFloat scaleR = scrollView.contentOffset.x/ScreenW;
    scaleR -= leftI;
    CGFloat scaleL = 1 - scaleR;
    
//    缩放按钮
    leftBtn.transform = CGAffineTransformMakeScale(scaleL*0.3+1, scaleL*0.3+1);
    rightBtn.transform = CGAffineTransformMakeScale(scaleR*0.3+1, scaleR*0.3+1);
    //    颜色渐变
    UIColor *rightColor = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
    UIColor *leftColor = [UIColor colorWithRed:scaleL  green:0 blue:0 alpha:1];
    [rightBtn setTitleColor:rightColor forState:UIControlStateNormal];
    [leftBtn setTitleColor:leftColor forState:UIControlStateNormal];
}
/*颜色：3种颜色通道组成：R红 G绿 B蓝  白色：111 黑色：000 红色：100*/
#pragma mark-----选中标题
-(void)selButton:(UIButton*)btn
{
    _selectBtn.transform = CGAffineTransformIdentity;
    [_selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _selectBtn = btn;
    
    //标题居中
    [self setupTitleCenter:btn];
    
//    字体缩放  形变
    btn.transform = CGAffineTransformMakeScale(1.3, 1.3);
    [self setupTitleScale];
}
#pragma mark ----字体缩放
-(void)setupTitleScale
{
    
}
#pragma mark----标题居中
-(void)setupTitleCenter:(UIButton*)btn
{
    //修改 titleScrollview偏移量
    CGFloat offsetX = btn.center.x - ScreenW*0.5;

    if (offsetX<0) {
        offsetX = 0;
    }
    CGFloat maxOffsetX = self.titleSV.contentSize.width-ScreenW;
    if (offsetX>maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    [self.titleSV setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    
}

-(void)setupTitleScrollView
{
    UIScrollView *titleSV = [[UIScrollView alloc]init];
//    titleSV.backgroundColor = [UIColor redColor];背景色和选中色一致，导致错误
    CGFloat y = self.navigationController.navigationBarHidden? 20:64;
    titleSV.frame = CGRectMake(0, y, self.view.bounds.size.width, 44);
    [self.view addSubview:titleSV];
    _titleSV = titleSV;
    
}
-(void)setupContentScrollView{

    UIScrollView *contentSV = [[UIScrollView alloc]init];
//    contentSV.backgroundColor = [UIColor greenColor];
    CGFloat y = CGRectGetMaxY(self.titleSV.frame);
    contentSV.frame = CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:contentSV];
    _contentSV = contentSV;
    
//    设置contentSV的属性
    self.contentSV.pagingEnabled = YES;
    self.contentSV.bounces = NO;//弹簧
    self.contentSV.showsHorizontalScrollIndicator = NO;//指示器
    
    //设置代理：监听内容滚动视图，什么时候滚动完成
    self.contentSV.delegate = self;
    
}
#pragma mark----UIScrollView delegate 滚动完成
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前角标
    NSInteger i = scrollView.contentOffset.x/ScreenW;
    //获取标题
    UIButton *titleBtn = self.titleBtns[i];
    //选中标题
    [self selButton:titleBtn];
//    把对应子控制器的View添加上去
    [self setupOneViewController:i];
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
