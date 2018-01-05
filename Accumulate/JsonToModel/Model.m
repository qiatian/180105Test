//
//  Model.m
//  Accumulation
//
//  Created by sanjingrihua on 16/12/29.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import "Model.h"

@implementation Model
-(NSDictionary *)parseModelsFromJson:(NSString *)jsonString
{
    id js=[NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSMutableArray *arr1,*arr2;
    if ([[js class] isSubclassOfClass:[NSArray class]]) {
        for (NSDictionary *dic in js) {
            if ([dic[@"ID"] integerValue]&&dic[@"time"]!=nil) {
                if (self ==[super init]) {
                    [self setValuesForKeysWithDictionary:dic];
                }
                [arr1 addObject:self];
                
            }
            else{
                if (self ==[super init]) {
                    [self setValuesForKeysWithDictionary:dic];
                }
                [arr2 addObject:self];
            }
        }
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy"];
        NSString* date = [[NSString alloc]initWithString:[formatter stringFromDate:[NSDate date]]];
        
        [dic setObject:arr1 forKey:date];
        [dic setObject:arr2 forKey:@"unknown"];
    }
    return dic;
}
@end
