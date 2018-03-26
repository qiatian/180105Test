//
//  TestModel.h
//  Accumulate
//
//  Created by sanjingrihua on 2018/2/27.
//  Copyright © 2018年 sanjingrihua. All rights reserved.
//

#import <Foundation/Foundation.h>
//枚举定义几种方式
typedef enum {
    TestEnum1 = 1,
    TestEnum2 = 10
}TestName;
typedef NS_ENUM(NSUInteger,EnumName){
    EnumType1 = 29,
    EnumType2 = 40
};
typedef NS_OPTIONS(NSUInteger, OptionsType) {
    OptionType1 = 1,
    OptionType2 = 3
};
typedef enum{
    TestStatus_Booking,
    TestStatus_Seated
}TestStatus;
@interface TestModel : NSObject

@property(nonatomic,strong)NSString *testName;
@property(nonatomic,assign)NSInteger pax;
@property(nonatomic,assign)TestStatus testStatus;
- (instancetype)initResWithRsName:(NSString *)name pax:(NSInteger)pax testStatus:(TestStatus)testStatus;
+ (instancetype)testWithName:(NSString *)name pax:(NSInteger)pax testStatus:(TestStatus)testStatus;
//-(void)doLogin;
@end
