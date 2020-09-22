//
//  HLDataRequest+HLHomeDataRequest.m
//  HeadLine
//
//  Created by admin on 2020/9/22.
//  Copyright © 2020 shelby. All rights reserved.
//

#import "HLDataRequest+HLHomeDataRequest.h"

@implementation HLDataRequest (HLHomeDataRequest)

- (void)getHomeData:(NSString *)url parameters:(id)parameters success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
    //1.判断是否有缓存
    
    if (NO) {
        
    }else {  //请求网络数据
        [[HLDataRequest sharedInstace] post:url parameters:parameters success:^(id  _Nonnull response) {
            success(response);
        } failure:^(NSError * _Nonnull error) {
            failure(error);
        }];
    }
}

@end
