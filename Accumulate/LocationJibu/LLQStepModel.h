//
//  LLQStepModel.h
//  Accumulation
//
//  Created by sanjingrihua on 16/12/12.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLQStepModel : NSObject
@property(nonatomic,strong)NSDate *date;
@property(nonatomic,copy)NSString *record_time;
@property(nonatomic,assign)int recore_no;
@property(nonatomic,assign)int step;
@property(nonatomic,assign)double g;
@end
