//
//  HLNetWorkManager.m
//  HeadLine
//
//  Created by admin on 2020/9/23.
//  Copyright © 2020 shelby. All rights reserved.
//

#import "HLNetWorkManager.h"
#import "AFNetworking.h"
@implementation HLNetWorkManager

+ (HLNetWorkManagerStatus)getNetWorkStatus {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch(status) {
                case AFNetworkReachabilityStatusNotReachable:
                break;
                case AFNetworkReachabilityStatusUnknown:
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                break;
            default:
                break;
        }
    }];
    return HLNetWorkManagerStatusWWAN;
}

@end
