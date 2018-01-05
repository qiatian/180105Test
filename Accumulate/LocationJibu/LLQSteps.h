//
//  LLQSteps.h
//  Accumulation
//
//  Created by sanjingrihua on 16/12/12.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLQSteps : NSObject
{
    
    
    NSMutableArray *arrAll;                 // 加速度传感器采集的原始数组
    int record_no_save;
    int record_no;
    NSDate *lastDate;
    
}
@property (nonatomic) NSInteger startStep;                          // 计步器开始步数

@property (nonatomic, retain) NSMutableArray *arrSteps;         // 步数数组
@property (nonatomic, retain) NSMutableArray *arrStepsSave;     // 数据库纪录步数数组

@property (nonatomic) float gpsDistance;                  // GPS轨迹的移动距离（总计）
@property (nonatomic) float agoGpsDistance;               // GPS轨迹的移动距离（之前）
@property (nonatomic) float agoActionDistance;            // 实际运动的移动距离（之前）

@property (nonatomic, retain) NSString *actionId;           // 运动识别ID
@property (nonatomic) float distance;                     // 运动里程（总计）
@property (nonatomic) NSInteger calorie;                    // 消耗卡路里（总计）
@property (nonatomic) NSInteger second;
@property (nonatomic) NSInteger step;
+(LLQSteps *)sharedManager;
-(void)startWithSteps;
@end
