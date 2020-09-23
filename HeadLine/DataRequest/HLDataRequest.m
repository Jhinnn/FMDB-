//
//  HLDataRequest.m
//  HeadLine
//
//  Created by 徐佳鹏 on 2020/9/19.
//  Copyright © 2020 shelby. All rights reserved.
//

#import "HLDataRequest.h"
#import "AFHTTPSessionManager.h"


#define Base_Url @"http://c.3g.163.com/nc/article/list/"

@interface HLDataRequest()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation HLDataRequest


- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

+ (instancetype)sharedInstace {
    static HLDataRequest *dataRequest = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataRequest = [HLDataRequest new];
    });
    return dataRequest;
}

- (void)post:(NSString *)url parameters:(id)parameters success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
    [self.manager POST:[NSString stringWithFormat:@"%@%@",Base_Url,url] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    
}

@end
