//
//  LLQStaus.h
//  Accumulation
//
//  Created by sanjingrihua on 17/4/13.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LLQStaus : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *picImg;
@property(nonatomic,assign,getter=isVip)BOOL vip;
@property(nonatomic,assign)CGRect headFram;
@property(nonatomic,assign)CGRect nameFram;
@property(nonatomic,assign)CGRect vipFram;
@property(nonatomic,assign)CGRect contentFram;
@property(nonatomic,assign)CGRect picFram;
@property(nonatomic,assign)CGFloat cellHeight;

@end
