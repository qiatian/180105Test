//
//  LLQSteps.m
//  Accumulation
//
//  Created by sanjingrihua on 16/12/12.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import "LLQSteps.h"
#import <CoreMotion/CoreMotion.h>
#import "LLQStepModel.h"

// 计步器开始计步时间（秒）
#define ACCELERO_START_TIME 2

// 计步器开始计步步数（步）
#define ACCELERO_START_STEP 100

// 数据库存储步数采集间隔（步）
#define DB_STEP_INTERVAL 1

@implementation LLQSteps
static LLQSteps *sharedManager;
static CMMotionManager *motionManager;
+(LLQSteps*)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager=[[LLQSteps alloc]init];
        motionManager=[[CMMotionManager alloc]init];
    });
    return sharedManager;
}
-(void)startWithSteps//计步
{
    if (motionManager.isAccelerometerAvailable) {
        motionManager.accelerometerUpdateInterval=1.0/40;
    }else{
        NSLog(@"加速度传感器不可用");
        return;
    }
    [self startAccelerometer];
}
-(void)startAccelerometer
{
    @try
    {
        if (!motionManager.isAccelerometerActive) {
            if (arrAll==nil) {
                arrAll=[[NSMutableArray alloc]init];
            }
            else{
                [arrAll removeAllObjects];
            }
            NSOperationQueue *queue = [[NSOperationQueue alloc]init];
            [motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
                if (!motionManager.isAccelerometerActive) {
                    return;
                }
                double x=accelerometerData.acceleration.x;
                double y=accelerometerData.acceleration.y;
                double z=accelerometerData.acceleration.z;
                
                double g=sqrt(pow(x, 2)+pow(y, 2)+pow(z, 2))-1;//根据g的大小来判断是非计为1步。
                
                LLQStepModel *stepsAll=[[LLQStepModel alloc]init];
                stepsAll.date=[NSDate date];
                
                NSDateFormatter *df=[[NSDateFormatter alloc]init];
                df.dateFormat=@"yyyy-MM-dd HH:mm:ss";
                NSString *strYmd=[df stringFromDate:stepsAll.date];
                df=nil;
                stepsAll.record_time=strYmd;
                
                stepsAll.g=g;
                
                [arrAll addObject:stepsAll];// 加速度传感器采集的原始数组
                
                // 每采集10条，大约1.2秒的数据时，进行分析
                if (arrAll.count==10) {
                    NSMutableArray *arrBuffer=[[NSMutableArray alloc]init];//步数缓存数组
                    arrBuffer =[arrAll copy];
                    [arrAll removeAllObjects];
                    
                    NSMutableArray *arrCaiDian=[[NSMutableArray alloc]init];// 踩点数组
                    
                    //遍历步数缓存数组
                    for (int i=1; i<arrBuffer.count-2; i++) {
                        //如果数组个数大于3,继续,否则跳出循环,用连续的三个点,要判断其振幅是否一样,如果一样,然并卵
                        if (![arrBuffer objectAtIndex:i-1]||![arrBuffer objectAtIndex:i]||![arrBuffer objectAtIndex:i+1]) {
                            continue;
                        }
                        LLQStepModel *bufferPrevious=(LLQStepModel*)[arrBuffer objectAtIndex:i-1];
                        LLQStepModel *bufferCurrent=(LLQStepModel*)[arrBuffer objectAtIndex:i];
                        LLQStepModel *bufferNext=[arrBuffer objectAtIndex:i+1];
                        //控制震动幅度,,,,,,根据震动幅度让其加入踩点数组,
                        if (bufferCurrent.g<-0.12&&bufferCurrent.g<bufferPrevious.g&&bufferCurrent.g<bufferNext.g) {
                            [arrCaiDian addObject:bufferCurrent];
                            
                        }
                    }
                    //如果没有步数数组,初始化
                    if (self.arrSteps==nil) {
                        self.arrSteps=[[NSMutableArray alloc]init];
                        self.arrStepsSave=[[NSMutableArray alloc]init];
                    }
                    
                    // 踩点过滤
                    for (int j=0; j<arrCaiDian.count; j++) {
                        LLQStepModel *caidianCurrent=[arrCaiDian objectAtIndex:j];
                        
                        //如果之前的步数为0,则重新开始记录
                        if (self.arrSteps.count==0) {
                            lastDate = caidianCurrent.date;//上次记录的时间
                            
                            // 重新开始时，纪录No初始化
                            record_no=1;
                            record_no_save=1;
                            
                            // 运动识别号
                            NSTimeInterval interval=[caidianCurrent.date timeIntervalSince1970];
                            NSNumber *numInter=[[NSNumber alloc]initWithDouble:interval *1000];
                            long long llInter=numInter.longLongValue;
                            //运动识别id
                            self.actionId=[NSString stringWithFormat:@"%lld",llInter];
                            
                            self.distance=0.000f;
                            self.second=0;
                            self.calorie=0;
                            self.step=0;
                            
                            self.gpsDistance=0.00f;
                            self.agoGpsDistance=0.00f;
                            self.agoActionDistance=0.00f;
                            
                            caidianCurrent.recore_no=record_no;
                            caidianCurrent.step=(int)self.step;
                            
                            [self.arrSteps addObject:caidianCurrent];
                            [self.arrStepsSave addObject:caidianCurrent];
                        }
                        else{
                            int intervalCaidian=[caidianCurrent.date timeIntervalSinceDate:lastDate]*1000;
                            // 步行最大每秒2.5步，跑步最大每秒3.5步，超过此范围，数据有可能丢失
                            int min=259;
                            if (intervalCaidian>=min) {
                                if (motionManager.isAccelerometerActive) {
                                    //存一下时间
                                    lastDate=caidianCurrent.date;
                                    
                                    if (intervalCaidian>=ACCELERO_START_TIME*1000) {// 计步器开始计步时间（秒)
                                        self.startStep=0;
                                        
                                        
                                    }
                                    if (self.startStep<ACCELERO_START_STEP) {//计步器开始计步数
                                        self.startStep++;
                                        break;
                                    }
                                    else if (self.startStep==ACCELERO_START_STEP){
                                        self.startStep++;
                                        // 计步器开始步数
                                        // 运动步数（总计）
                                        self.step = self.step + self.startStep;
                                        
                                    
                                    }
                                    else{
                                        self.step++;
                                    }
                                    
                                    int intervalMillSecond=[caidianCurrent.date timeIntervalSinceDate:[[self.arrSteps lastObject] date]] *1000;
                                    if (intervalMillSecond>=1000) {
                                        record_no++;
                                        caidianCurrent.recore_no=record_no;
                                        caidianCurrent.step=(int)self.step;
                                        [self.arrSteps addObject:caidianCurrent];
                                    }
                                    // 每隔100步保存一条数据（将来插入DB用）
                                    LLQStepModel *arrStepsSaveVHSSteps=(LLQStepModel*)[self.arrStepsSave lastObject];
                                    int intervalStep=caidianCurrent.step-arrStepsSaveVHSSteps.step;
                                    // DB_STEP_INTERVAL 数据库存储步数采集间隔（步） 100步
                                    if (self.arrStepsSave.count==1||intervalStep>=DB_STEP_INTERVAL) {
                                        //保存次数
                                        record_no_save++;
                                        caidianCurrent.recore_no=record_no_save;
                                        [self.arrStepsSave addObject:caidianCurrent];
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }];
        }
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
        return;
    } @finally {
        
    }
}
-(id)init
{
    if (self==[super init]) {
        CMMotionManager *mom=[[CMMotionManager alloc]init];
        if (!mom.accelerometerAvailable) {
            NSLog(@"陀螺仪不可用");
            
        }
        else{
            CMPedometer *pedometer=[[CMPedometer alloc]init];
            [pedometer queryPedometerDataFromDate:[NSDate dateWithTimeIntervalSince1970:100] toDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
                
                if (!error) {
                    NSLog(@"这段时间走过的距离：%@,步数：%@,上楼台阶数：%@,下楼台阶数:%@",pedometerData.distance,pedometerData.numberOfSteps,pedometerData.floorsAscended,pedometerData.floorsDescended);
                }else{
                    NSLog(@"错误信息编号：%@",error);
                }
            }];
        }
    }
    return self;
}
@end
