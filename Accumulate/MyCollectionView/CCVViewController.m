//
//  CCVViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 17/4/6.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "CCVViewController.h"
#import "LLQFlowLayout.h"
@interface CCVViewController ()<UICollectionViewDataSource>

@end

@implementation CCVViewController
#define ScreenW self.view.bounds.size.width
static NSString * const ID = @"Cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //流水布局  方式1；
//    UICollectionViewFlowLayout *layout = [self setupCollectionViewFlowLayout];
//    [self setupCollectionView:layout];
//    
    
    //流水布局  方式2；
    LLQFlowLayout *layout1 = ({
        LLQFlowLayout *layout = [[LLQFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(120, 120);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat margin = (ScreenW - 120)*0.5;
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        layout.minimumLineSpacing = 30;//行间距
        layout.minimumInteritemSpacing = 0;//最小的item间距
        layout;
    });
    //collectionview布局
    UICollectionView *collectionView1 = ({
        UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout1];
        collectView.backgroundColor = [UIColor brownColor];
        collectView.center = self.view.center;
        collectView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 200);
        collectView.showsHorizontalScrollIndicator = NO;//关闭水平滚动条
        [self.view addSubview:collectView];
        
        collectView.dataSource = self;//数据源
        
        
        collectView;
    });
    [collectionView1 registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
}
#pragma mark-----流水布局
-(UICollectionViewFlowLayout *)setupCollectionViewFlowLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(120, 120);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat margin = (ScreenW - 120)*0.5;
    layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    layout.minimumLineSpacing = 30;//行间距
    layout.minimumInteritemSpacing = 0;//最小的item间距
    
    return layout;
}
#pragma mark-----UICollectionView
-(void)setupCollectionView:(UICollectionViewFlowLayout *)layout
{
    UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectView.backgroundColor = [UIColor brownColor];
    collectView.center = self.view.center;
    collectView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    collectView.showsHorizontalScrollIndicator = NO;//关闭水平滚动条
    [self.view addSubview:collectView];
    
    collectView.dataSource = self;//数据源
    
    [collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
}
#pragma mark------UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor purpleColor];
    
    return cell;
    
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
