//
//  LLQVendorToll.m
//  Accumulation
//
//  Created by sanjingrihua on 17/4/28.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "LLQVendorToll.h"
#import "LLQKeyChainTool.h"

@implementation LLQVendorToll
+ (NSString *)getIDFV
{
    NSString *IDFV = (NSString *)[LLQKeyChainTool load:@"IDFV"];
    
    if ([IDFV isEqualToString:@""] || !IDFV) {
        
        IDFV = [UIDevice currentDevice].identifierForVendor.UUIDString;
        [LLQKeyChainTool save:@"IDFV" data:IDFV];
    }
    
    return IDFV;
}
@end
