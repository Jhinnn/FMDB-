//
//  DataBaseManger.m
//  HeadLine
//
//  Created by admin on 2020/9/22.
//  Copyright © 2020 shelby. All rights reserved.
//

#import "HLDataBaseManger.h"
#import "HLModel.h"
@interface HLDataBaseManger()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation HLDataBaseManger

+ (instancetype)defaultMangeer {
    static HLDataBaseManger *manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        manager = [[self alloc] init];
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        
        NSString *dbPath = [path stringByAppendingPathComponent:@"HeadLine.sqlite"];
        
        manager.db = [FMDatabase databaseWithPath:dbPath];
        
        [manager.db open];
    });
    
    return manager;
}


/// 创建表
- (void)setupTable {
    if ([self.db isOpen]) {
        if (![self.db tableExists:@"newsTable"]) {
            BOOL result = [self.db executeUpdate:@"create table if not exists newsTable (id integer primary key,dict blob not null ,keyPath text not null, createTime text not null);"];
            if (!result) {
                NSLog(@"创建表失败");
            }
            [self.db close];
        }
    }
}


/// 根据 key 接口地址缓存接口请求数据
/// @param dict 数据
/// @param key 接口地址
- (BOOL)saveDatas:(NSDictionary *)dict key:(NSString *)key   {
    //将数据用归档的方式转换成NSData，避免写复杂的sql语句。
    [self.db open];
    NSData *data = [self dictToData:dict];
    BOOL result = [self.db executeUpdate:@"Insert into newsTable (dict, keyPath, createTime) values (?,?,?);",data,key,[self getNowTimeTimestamp]];
    if (result) {
        NSLog(@"缓存成功...");
    }else {
        NSLog(@"缓存失败...");
    }
    [self.db close];
    return result;
}

- (BOOL)hasCache:(NSString *)key {
    [self.db open];
    FMResultSet *set = [self.db executeQuery:@"select * from newsTable where keyPath = ?;",key];
    while (set.next) {
        return YES;
    }
    [self.db close];
    return NO;
}


/// 返回该接口缓存的数据 NSDictionary
/// @param key 接口地址后缀
- (NSDictionary *)queryDatas:(NSString *)key {
    NSLog(@"加载缓存数据。。。。");
    [self.db open];
    FMResultSet *set = [self.db executeQuery:@"select * from newsTable where keyPath = ?;",key];
    NSMutableData *mutaData = [[NSMutableData alloc] initWithCapacity:10];
    while (set.next) {
        NSData *data = [set dataForColumn:@"dict"];
        [mutaData appendData:data];
    }
    NSDictionary *datas = [self dataToDict:mutaData.copy];
    if (!datas) {
        NSLog(@"%@接口，没有缓存数据",key);
    }
    [self.db close];
    return datas;
}


/// 是否已经需要重新加载网络数据，不再加载缓存
/// @param key 地址
- (BOOL)isNeedToRequest:(NSString *)key {
    [self.db open];
    FMResultSet *set = [self.db executeQuery:@"select createTime from newsTable where keyPath = ?;",key];
    while (set.next) {
        NSString *createTime = [set stringForColumn:@"createTime"];
        if ([self calculateTime:createTime]) {
            return YES;
        }
    }
    [self.db close];
    return NO;
}

- (BOOL)deleteData:(NSString *)key {
    [self.db open];
    BOOL result = [self.db executeUpdate:@"delete from newsTable where keyPath = ?;",key];
    if (result) {
        NSLog(@"删除缓存数据成功");
    }else {
        NSLog(@"删除缓存数据失败");
    }
    [self.db close];
    return result;
}


- (NSData *)dictToData:(NSDictionary *)dict {
    NSError *err = nil;
    return [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&err];
}

- (NSDictionary *)dataToDict:(NSData *)data {
    NSError *err = nil;
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
}

- (NSString *)getNowTimeTimestamp{
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}

- (BOOL)calculateTime:(NSString *)startTimestamp {
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[[self getNowTimeTimestamp] doubleValue]];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[startTimestamp doubleValue]];
    NSTimeInterval seconds = [date timeIntervalSinceDate:date2];
    if (seconds >= 600) {
        return YES;
    }
    return NO;
}

@end
