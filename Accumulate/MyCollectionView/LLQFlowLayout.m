//
//  LLQFlowLayout.m
//  Accumulation
//
//  Created by sanjingrihua on 16/11/24.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import "LLQFlowLayout.h"
/* 
 自定义布局需要了解五个方法
 */
@implementation LLQFlowLayout
//重写方法，扩展功能
//计算cell的布局，条件：cell的位置是固定不变     第一次布局调用，刷新也会布局
-(void)prepareLayout
{
    [super prepareLayout];
}
/*
 UICollectionViewLayoutAttributes:确定cell的尺寸
 一个UICollectionViewLayoutAttributes对象就对应一个cell
 拿到UICollectionViewLayoutAttributes相当于拿到cell
 */
//作用:返回cell的尺寸  指定一段区域的cell的尺寸
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //越靠近中心点，越大，求cell与中心点距离
    //获取当前显示区域
//    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    //获取当前显示cell的布局
    NSArray *attrs= [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    for (UICollectionViewLayoutAttributes *attr in attrs) {
//        计算cell与中心点距离
        CGFloat delta=fabs(attr.center.x-self.collectionView.contentOffset.x-self.collectionView.bounds.size.width*0.5);
//        计算比例() 距离越小，缩放越大
        CGFloat scale =1- delta/(self.collectionView.bounds.size.width*0.5)*0.35;
        
        attr.transform=CGAffineTransformMakeScale(scale, scale);
    }
    return attrs;
}
//确定最终偏移量  用户手指一松就会调用  定位：距离中心点越近，这个cell最终展示到中心  定位
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    NSLog(@"%s",__func__);
    //拖动比较快 最终偏移量 不等于 手指离开时偏移量
    
    
    //最终偏移量
    CGPoint targetP = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    
    //获取最终显示的区域
    CGRect targetRect=CGRectMake(targetP.x, 0, self.collectionView.bounds.size.width, MAXFLOAT);
    
    //获取最终显示的cell
    NSArray *attrs=[super layoutAttributesForElementsInRect:targetRect];
    
    CGFloat minDelta=MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr  in attrs) {
        //获取距离中心点距离
        CGFloat delta=(attr.center.x - self.collectionView.contentOffset.x)-self.collectionView.bounds.size.width*0.5;
        if (fabs(delta)<fabs(minDelta)) {
            minDelta=delta;
        }
    
    }
    targetP.x += minDelta;
    if (targetP.x<0) {
        targetP.x=0;
    }
    //获取collectionview 偏移量
    NSLog(@"%@  %@",NSStringFromCGPoint(targetP),NSStringFromCGPoint(self.collectionView.contentOffset));
    return targetP;
}
//在滚动的时候是否允许刷新布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
//    return [super shouldInvalidateLayoutForBoundsChange:newBounds];
    return YES;
}
//计算collectionview 滚动范围
-(CGSize)collectionViewContentSize
{
    return [super collectionViewContentSize];
}
@end
