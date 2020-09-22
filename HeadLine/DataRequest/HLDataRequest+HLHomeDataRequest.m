//
//  HLDataRequest+HLHomeDataRequest.m
//  HeadLine
//
//  Created by admin on 2020/9/22.
//  Copyright © 2020 shelby. All rights reserved.
//

#import "HLDataRequest+HLHomeDataRequest.h"
#import "HLDataBaseManger.h"
@implementation HLDataRequest (HLHomeDataRequest)

- (void)getHomeData:(NSString *)url parameters:(id)parameters success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
    //1.判断是否有缓存
    if ([[HLDataBaseManger sharedInstance] queryDatas:url]) {
        success([[HLDataBaseManger sharedInstance] queryDatas:url]);
    }else {  //请求网络数据
        [[HLDataRequest sharedInstace] post:url parameters:parameters success:^(id  _Nonnull response) {
            [self saveCacheData:response key:url];
            success(response);
        } failure:^(NSError * _Nonnull error) {
            failure(error);
        }];
    }
}

- (void)saveCacheData:(NSDictionary *)dict key:(NSString *)key {
    NSLog(@"开始缓存数据了。。。。。。。。");
    [[HLDataBaseManger sharedInstance] saveDatas:dict key:key];
}




@end
