//
//  HLModel.h
//  HeadLine
//
//  Created by 徐佳鹏 on 2020/9/19.
//  Copyright © 2020 shelby. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLModel : NSObject

@property (nonatomic, copy) NSString *docid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *digest;
@property (nonatomic, copy) NSString *imgsrc;


@end

NS_ASSUME_NONNULL_END
