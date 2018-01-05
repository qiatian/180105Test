//
//  PullExtendViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 17/9/14.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "PullExtendViewController.h"

@interface PullExtendViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGRect originalFrame;
}
@property(nonatomic,strong)UIImageView *bgImgView;
@end
#define headHeight ScreenW/2
@implementation PullExtendViewController
static NSString *cellID =@"Cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //背景图
    _bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenW, ScreenW)];
    _bgImgView.image = [UIImage imageNamed:@"1.png"];
    originalFrame = _bgImgView.frame;
    [self.view addSubview:_bgImgView];
    
    //导航栏
    self.navigationItem.title = @"可拉伸上下";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];

    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 64.0f, ScreenW, ScreenH) style:UITableViewStylePlain];
    table.backgroundColor = [UIColor clearColor];
    table.showsVerticalScrollIndicator = NO;
    table.delegate = self;
    table.dataSource = self;
    
    //contentInset实质是修改bounds
//    table.contentInset = UIEdgeInsetsMake(ScreenW/2, 0.f, 0.f, 0.f);
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenW, ScreenW/2)];
    headView.backgroundColor = [UIColor clearColor];
    table.tableHeaderView = headView;
    
    [self.view addSubview:table];
    
//    [table insertSubview:bgImgView atIndex:0]; 加到table后边，不行
}
#pragma mark-----tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
    
}
#pragma mark-----scrollviewdelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //  往上滑动，offset是增加的，往下滑动，offset是减少的
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset<headHeight) {//当滑动到导航栏底部前
        CGFloat colorAlpha = yOffset/headHeight;
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:colorAlpha]];
    }else{//当滑动超过导航栏底部了
        
    }
    
    //处理放大效果、往上移动的效果
    if (yOffset>0) {//往上移动 修改y坐标
        self.bgImgView.frame = ({
            CGRect frame = _bgImgView.frame;
            frame.origin.y = originalFrame.origin.y - yOffset;
            frame;
        });
    }else{
        self.bgImgView.frame = ({
            CGRect frame = originalFrame;
            frame.size.height = originalFrame.size.height - yOffset;
            frame.size.width = frame.size.height/0.8;
            frame.origin.x = originalFrame.origin.x - (frame.size.width-originalFrame.size.width)/2;
            frame;
        });
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
