//
//  NSDictionary+Property.m
//  Accumulation
//
//  Created by sanjingrihua on 17/5/27.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "NSDictionary+Property.h"

@implementation NSDictionary (Property)
//生成属性代码＝》根据字典中所有key  isKindOfClass判断是当前类或子类
-(void)createProperyCode
{
    NSMutableString *codes = [NSMutableString string];
//    遍历字典
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"key:%@ value:%@",key,obj);
        NSLog(@"+++++++%@",[obj class]);
        NSString *code;
        if ([obj isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property(nonatomic,strong)NSString *%@;",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property(nonatomic,assign) BOOL %@;",key];
        }else if ([obj isKindOfClass:[NSNumber class]]){
            code = [NSString stringWithFormat:@"@property(nonatomic,assign) NSInteger %@;",key];
        }else if ([obj isKindOfClass:[NSArray class]]){
            code = [NSString stringWithFormat:@"@property(nonatomic,strong)NSArray *%@;",key];
        }else if ([obj isKindOfClass:[NSDictionary class]]){
            code = [NSString stringWithFormat:@"@property(nonatomic,strong)NSDictionary *%@;",key];
        }
        
        [codes  appendFormat:@"\n%@\n",code];
    }];
    
    NSLog(@"%@",codes);
}
@end
