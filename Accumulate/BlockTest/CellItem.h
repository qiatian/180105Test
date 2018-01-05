//
//  CellItem.h
//  Accumulation
//
//  Created by sanjingrihua on 17/6/16.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellItem : NSObject
//设置模型  控件需要展示什么内容，就定义什么属性
@property(nonatomic,strong)NSString *title;
//保存每个cell做的事情
@property(nonatomic,strong)void(^blockCell)();
+(instancetype)itemWithTitle:(NSString*)title;

@end
