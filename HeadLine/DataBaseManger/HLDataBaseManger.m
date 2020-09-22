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

+ (instancetype)sharedInstance {
    static HLDataBaseManger *manger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [HLDataBaseManger new];
    });
    return manger;
}


- (void)createDataBaseAndTable {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [path stringByAppendingPathComponent:@"HeadLine.sqlite"];
    
    self.db = [FMDatabase databaseWithPath:dbPath];
    
    if (![self.db open]) {
        NSLog(@"数据库打开失败。。。");
    }else {
        NSLog(@"数据库打开成功。。。");
        [self createTable];
    }
}

//@property (nonatomic, copy) NSString *docid;
//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *digest;
//@property (nonatomic, copy) NSString *imgsrc;
- (void)createTable {
    BOOL result = [self.db executeUpdate:@"create table if not exists newsTable (id integer primary key,dict blob not null ,keyPath text not null);"];
    if (!result) {
        NSLog(@"创建newsTable表失败。。。");
    }else {
        NSLog(@"创建newsTable表成功。。。");
        [self.db close];
    }
}

- (void)dropTable {
    [self.db open];
    BOOL result = [self.db executeQuery:@"drop table newsTable;"];
    if (!result) {
        NSLog(@"删除newsTable表失败。。。");
    }else {
        NSLog(@"删除newsTable表成功。。。");
        [self.db close];
    }
}

- (void)saveDatas:(NSArray *)datas key:(NSString *)key {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:datas requiringSecureCoding:YES error:nil];
     [self.db executeQuery:@"Insert into newsTable (dict, keyPath) values (?,?);",data,key];
}

- (NSArray *)queryDatas:(NSString *)key {
    FMResultSet *set = [self.db executeQuery:@"select * from newsTable where keyPath = ?",key];
    while (set.next) {
        NSData *data = [set objectForColumn:@"dict"];
        NSArray *datas = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSArray class] fromData:data error:nil];
    }
    return @[];
}

//- (void)saveDataWithModel:(HLModel *)model {
//    [self.db open];
//    NSString *sqlString = @"insert into newsTable (docid, title, digest, imgsrc) values (?,?,?,?);";
//    BOOL result = [self.db executeUpdate:sqlString,model.docid,model.title,model.digest,model.imgsrc];
//    if (!result) {
//        NSLog(@"数据插入失败。。。");
//    }else {
//        NSLog(@"数据插入成功。。。");
//    }
//    [self.db close];
//}


@end
