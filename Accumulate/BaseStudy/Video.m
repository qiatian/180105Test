//
//  Video.m
//  Accumulate
//
//  Created by sanjingrihua on 2018/5/22.
//  Copyright © 2018年 sanjingrihua. All rights reserved.
//

#import "Video.h"

@implementation Video
- (NSString *)time{
    int len = self.length.intValue;
    return [NSString stringWithFormat:@"%02d:%02d:%02d",len/3600,(len%3600)/60,(len%60)];
}
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}
+ (instancetype)videoWithDict:(NSDictionary *)dic{
    return [[self alloc] initWithDictionary:dic];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
- (NSString *)description{
    return [NSString stringWithFormat:@"<%@:%p>{videoid:%@,name:%@,length:%@,videoURL:%@,imageURL:%@,description:%@,teacher:%@}",[self class],self,self.videoid,self.name,self.length,self.videoURL,self.imageURL,self.description,self.teacher];
}
@end
