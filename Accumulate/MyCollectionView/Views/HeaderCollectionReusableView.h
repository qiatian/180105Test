//
//  HeaderCollectionReusableView.h
//  BeautifyVastCollect
//
//  Created by sanjingrihua on 17/3/20.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderCollectionReusableView : UICollectionReusableView<UIScrollViewDelegate>
{
    UIScrollView *topScroll;
    NSTimer *timer;
}
@end
