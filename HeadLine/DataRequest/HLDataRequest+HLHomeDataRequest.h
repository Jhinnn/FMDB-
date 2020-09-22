//
//  HLDataRequest+HLHomeDataRequest.h
//  HeadLine
//
//  Created by admin on 2020/9/22.
//  Copyright © 2020 shelby. All rights reserved.
//

#import "HLDataRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface HLDataRequest (HLHomeDataRequest)


- (void)getHomeData:(NSString *)url parameters:(id)parameters success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
