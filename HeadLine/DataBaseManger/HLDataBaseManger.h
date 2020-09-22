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

@interface HLDataBaseManger : NSObject

+ (instancetype)sharedInstance;

- (void)createDataBaseAndTable;

- (void)dropTable;

- (void)saveDatas:(NSArray *)datas key:(NSString *)key;

- (NSArray *)queryDatas:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
