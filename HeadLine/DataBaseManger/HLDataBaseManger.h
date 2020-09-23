//
//  DataBaseManger.h
//  HeadLine
//
//  Created by admin on 2020/9/22.
//  Copyright © 2020 shelby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@class HLModel;
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    HLDataBaseMangerCacheMore10Min,
    HLDataBaseMangerCacheLess10Min,
    HLDataBaseMangerNoCache,
} HLDataBaseMangerType;

@interface HLDataBaseManger : NSObject

+ (instancetype)defaultMangeer;

- (void)setupTable;

- (BOOL)saveDatas:(NSDictionary *)dict key:(NSString *)key;

- (NSDictionary *)queryDatas:(NSString *)key;

- (BOOL)isNeedToRequest:(NSString *)key;

- (BOOL)hasCache:(NSString *)key;

- (BOOL)deleteData:(NSString *)key;

- (BOOL)calculateTime:(NSString *)startTimestamp;

@end

NS_ASSUME_NONNULL_END
