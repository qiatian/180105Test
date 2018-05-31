//
//  Person+mult.m
//  Accumulate
//
//  Created by sanjingrihua on 2018/4/11.
//  Copyright © 2018年 sanjingrihua. All rights reserved.
//

#import "Person+mult.h"
#import <objc/runtime.h>
@implementation Person (mult)
const char* name = "nick";
- (void)setNick:(NSString *)nick{
    objc_setAssociatedObject(self, &name, nick, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)nick{
    return objc_getAssociatedObject(self, &name);
}
@end
