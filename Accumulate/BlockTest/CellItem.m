//
//  CellItem.m
//  Accumulation
//
//  Created by sanjingrihua on 17/6/16.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "CellItem.h"

@implementation CellItem
+(instancetype)itemWithTitle:(NSString *)title
{
    CellItem *item = [[self alloc]init];
    item.title = title;
    return item;
}
@end
