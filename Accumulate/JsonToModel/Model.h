//
//  Model.h
//  Accumulation
//
//  Created by sanjingrihua on 16/12/29.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
@property (nonatomic,assign)int ID;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSArray *tags;
@property (nonatomic,strong)NSDate *time;
@property (nonatomic,assign)BOOL isActive;
/*
 当 jsonString 可以解析为数组时，如果数组的中的元素是一个字典，
 并且 key “id” 的值是整数时，将其解析为 Model 对象，尽可能宽容
 地解析每个字段，不存在或无法解析的字段填充默认值。
 
 参数：jsonString 一段不明来源的字符串，可能是任意内容
 返回值：一个字典。key 是年份字符串，格式如“2016”，对应的值是该
 年份下所有的Model对象的数组，按时间先后排序。
 如果存在time属性为nil的对象，所有的 time == nil 的对象都放在
 同一个数组中，该数组在字典中对应的key是“unknown”。
 */
-(NSArray *)parseModelsFromJson:(NSString *)jsonString;
@end
