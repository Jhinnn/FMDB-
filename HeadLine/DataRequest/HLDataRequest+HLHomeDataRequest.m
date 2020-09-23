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
    if ([[HLDataBaseManger defaultMangeer] hasCache:url]) {  //有缓存
        //2.缓存是否过期了
        if ([[HLDataBaseManger defaultMangeer] isNeedToRequest:url]) { //过期了 重新请求网络数据
            //3.删除过期缓存数据
            [[HLDataBaseManger defaultMangeer] deleteData:url];
            [self requestData:url parameters:parameters success:^(id response) {
                success(response);
            } failure:^(NSError *error) {
                failure(error);
            }];
        }else { //没有过期 返回缓存数据
            success([[HLDataBaseManger defaultMangeer] queryDatas:url]);
        }
    }else {  //没有缓存 请求网络数据
        [self requestData:url parameters:parameters success:^(id response) {
            success(response);
        } failure:^(NSError *error) {
            failure(error);
        }];
    }
}


/// 通用网络请求
/// @param url 地址
/// @param parameters 参数
/// @param success 成功block
/// @param failure 失败block
- (void)requestData:(NSString *)url parameters:(id)parameters success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
    
    [[HLDataRequest sharedInstace] post:url parameters:parameters success:^(id  _Nonnull response) {
    
        [self saveCacheData:response key:url];
        
        success(response);
        
    } failure:^(NSError * _Nonnull error) {
        
        failure(error);
    }];
            
        
}


/// 缓存请求的数据
/// @param dict 数据
/// @param key 地址
- (void)saveCacheData:(NSDictionary *)dict key:(NSString *)key {
    [[HLDataBaseManger defaultMangeer] saveDatas:dict key:key];
}

/// 删除过期缓存数据
/// @param key 地址
- (void)removeCacheData:(NSString *)key {
    [[HLDataBaseManger defaultMangeer] deleteData:key];
}



@end
