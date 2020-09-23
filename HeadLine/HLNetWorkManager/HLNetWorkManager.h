//
//  HLNetWorkManager.h
//  HeadLine
//
//  Created by admin on 2020/9/23.
//  Copyright © 2020 shelby. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    HLNetWorkManagerStatusNotReachable,
    HLNetWorkManagerStatusUnknown,
    HLNetWorkManagerStatusWifi,
    HLNetWorkManagerStatusWWAN
} HLNetWorkManagerStatus;

@interface HLNetWorkManager : NSObject


@property (nonatomic, assign) HLNetWorkManagerStatus netWorkManagerStatus;

+ (HLNetWorkManagerStatus)getNetWorkStatus;

@end

NS_ASSUME_NONNULL_END
