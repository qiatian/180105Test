//
//  StatusItem.h
//  Accumulation
//
//  Created by sanjingrihua on 17/5/27.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import <Foundation/Foundation.h>
//设计模型有哪些属性 ＝》 字典 KVC：模型中属性必须与字典中key一一对应
@interface StatusItem : NSObject
//自动生成属性＝》根据字典
@property(nonatomic,strong)NSString *name;
+(instancetype)itemWithDict:(NSDictionary*)dict;
@end
