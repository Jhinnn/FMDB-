//
//  HLDataRequest.h
//  HeadLine
//
//  Created by 徐佳鹏 on 2020/9/19.
//  Copyright © 2020 shelby. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLDataRequest : NSObject



+ (instancetype)sharedInstace;

- (void)post:(NSString *)url parameters:(id)parameters success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;



@end

NS_ASSUME_NONNULL_END
