//
//  LLQSqliteManager.m
//  Accumulation
//
//  Created by sanjingrihua on 16/12/8.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import "LLQSqliteManager.h"

@implementation LLQSqliteManager
static id _instance;
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[super allocWithZone:zone];
    });
    return _instance;
}
+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[[self alloc]init];
    });
    return _instance;
    
    
}
- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}
#if __has_feature(objc_arc)
#else
-(oneway void)release{
}
-(instancetype)retain{
    return _instance;
}
-(NSUInteger)retainCount{
    return MAXFLOAT;
}
#endif

+(NSString *)pathStr
{
    NSArray *documentArr=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[documentArr firstObject];
    NSString *path=[NSString stringWithFormat:@"%@/llqfirst.db",documentPath];
    return path;
}
-(void)createSqlite
{
    NSArray *documentArr=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[documentArr firstObject];
    NSString *path=[NSString stringWithFormat:@"%@/llqfirst.db",documentPath];
    
    int databaseResult=sqlite3_open([path UTF8String], &database);
    if (databaseResult!=SQLITE_OK) {
        NSLog(@"创建／打开数据库失败，%d",databaseResult);
    }
}
-(void)createTable
{
    char *error;
    
    const char *createSql= "create table if not exists list(id integer primary key autoincrement,name char,sex char)";
    
    int tableResult=sqlite3_exec(database, createSql, NULL, NULL, &error);
    
    if (tableResult !=SQLITE_OK) {
        NSLog(@"创建表失败：%s",error);
    }
}
-(void)insertTable
{
    sqlite3_stmt *stmt;
    // 对SQL语句执行预编译
    int sqlite3_prepare(sqlite3 *db, const char *sql,int byte,sqlite3_stmt **stmt,const char **tail);
    //   添加
    //   sql语句格式: insert into 表名 (列名)values(值)
    const char *insertSQL = "insert into haha (name,sex)values('iosRunner','male')";
    int insertResult = sqlite3_prepare_v2(database, insertSQL, -1, &stmt, nil);
    
    if (insertResult != SQLITE_OK) {
        NSLog(@"添加失败,%d",insertResult);
    }
    else{
        //           执行sql语句
        sqlite3_step(stmt);
    }
}
//删除数据
- (void)delete
{
    //1.准备sqlite语句
    NSString *sqlite = [NSString stringWithFormat:@"delete from student where number = '1'"];
    //2.执行sqlite语句
    char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
    int result = sqlite3_exec(database, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"删除数据成功");
    } else {
        NSLog(@"删除数据失败%s",error);
    }
}

//修改数据
- (void)updataWithStu
{
    //1.sqlite语句
    NSString *sqlite = [NSString stringWithFormat:@"update student set name = '1',sex = '1',age = '1' where number = '1'"];
    //2.执行sqlite语句
    char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
    int result = sqlite3_exec(database, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"修改数据成功");
    } else {
        NSLog(@"修改数据失败");
    }
}

//查询所有数据
- (NSMutableArray*)selectWithStu {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //1.准备sqlite语句
    NSString *sqlite = [NSString stringWithFormat:@"select * from student"];
    //2.伴随指针
    sqlite3_stmt *stmt = NULL;
    //3.预执行sqlite语句
    int result = sqlite3_prepare(database, sqlite.UTF8String, -1, &stmt, NULL);//第4个参数是一次性返回所有的参数,就用-1
    if (result == SQLITE_OK) {
        NSLog(@"查询成功");
        //4.执行n次
        while (sqlite3_step(stmt) == SQLITE_ROW) {
//            student *stu = [[student alloc] init];
//            //从伴随指针获取数据,第0列
//            stu.number = sqlite3_column_int(stmt, 0);
//            //从伴随指针获取数据,第1列
//            stu.name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)] ;
//            //从伴随指针获取数据,第2列
//            stu.sex = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)] ;
//            //从伴随指针获取数据,第3列
//            stu.age = sqlite3_column_int(stmt, 3);
//            [array addObject:stu];
        }
    } else {
        NSLog(@"查询失败");
    }
    //5.关闭伴随指针
    sqlite3_finalize(stmt);
    return array;
}

#pragma mark - 4.关闭数据库
- (void)closeSqlite {
    
    int result = sqlite3_close(database);
    if (result == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
    } else {
        NSLog(@"数据库关闭失败");
    }
}
@end
