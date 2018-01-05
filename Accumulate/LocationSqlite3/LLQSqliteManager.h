//
//  LLQSqliteManager.h
//  Accumulation
//
//  Created by sanjingrihua on 16/12/8.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface LLQSqliteManager : NSObject
{
    sqlite3 *database;
}
+(NSString *)pathStr;
@end
