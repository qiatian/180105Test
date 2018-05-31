//
//  Video.h
//  Accumulate
//
//  Created by sanjingrihua on 2018/5/22.
//  Copyright © 2018年 sanjingrihua. All rights reserved.
//属性数值数据类型，最好设置为对象数据类型NSNumber，防止返回null，无法使用kvc

#import <Foundation/Foundation.h>

@interface Video : NSObject
@property(nonatomic,strong)NSNumber *videoid;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSNumber *length;
@property(nonatomic,copy)NSString *videoURL;
@property(nonatomic,copy)NSString *imageURL;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *teacher;

@property(nonatomic,readonly)NSString *time;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)videoWithDict:(NSDictionary *)dic;
@end
