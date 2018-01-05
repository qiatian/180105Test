//
//  LLQADViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 17/5/23.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//  http://ww2.sinaimg.cn/large/005P15krjw1f295a662sej30go3xl464.jpg

#import "LLQADViewController.h"
#import "LLQADItem.h"
//

@interface LLQADViewController ()
@property (weak, nonatomic) IBOutlet UIView *adContainView;
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
@property(nonatomic,weak)UIImageView *adView;
@property(nonatomic,strong) LLQADItem *item;
@property(nonatomic,weak)NSTimer *timer;
@end

@implementation LLQADViewController
-(UIImageView*)adView
{
    if (_adView==nil) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self.adContainView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        
        _adView = imageView;
    }
    return _adView;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}
-(void)caculateImg
{
//    开启上下文
    UIGraphicsBeginImageContext(CGSizeMake(ScreenW, ScreenW));
    [self.adView.image drawInRect:CGRectMake(0, 0, ScreenW, ScreenW)];
    self.adView.image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
}
//
/*1.weak->OC对象（代理） 2.assign->基本数据类型；OC对象 3.strong－>OC对象 4.copy －>nsstring ＊；block
 __weak所指向的对象销毁后，会自动变成nil指针，不再指向已销毁的对象
 __unsafe_unretained所指向的对象销毁后,仍旧指向已销毁的对象
 */
//点击广告界面调用
-(void)tap{
    NSURL *url = [NSURL URLWithString:_item.url];
    UIApplication * app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupLaunchImage];
    
    [self loadADData];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}
-(void)timeChange
{
    NSLog(@"timeChange");
    static int i = 3;
    
    
    if (i==0) {
        //销毁广告界面,进入主框架界面
//        干掉定时器
        [_timer invalidate];
        
    }
    i--;
    //设置跳转按钮文字
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳转（%d)",i] forState:UIControlStateNormal];
    
}
#pragma mark------加载广告数据
-(void)loadADData{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://mobads.baidu.com/cpro/ui/mads.php"];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [data writeToFile:@"" atomically:YES];
//        //获取字典
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
////        字典转模型
//        self.item ;
        //创建UIImageView展示图片＝＝》
        CGFloat modelw,modelh;
        CGFloat h = ScreenW/modelw * modelh;
        self.adView.frame = CGRectMake(0, 0, ScreenW, h);
//        [self.adView sd_setImageVithURL:[NSURL URLWithString:@"model.picurl"]];
    }];
    [task resume];

}
//设置启动图片
-(void)setupLaunchImage
{
    if (ScreenH == 736) {
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-736@3x"];
    }else if (ScreenH == 667){
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-667"];
    }else if (ScreenH == 568){
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-568"];
    }else if (ScreenH == 480){
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-480"];
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
