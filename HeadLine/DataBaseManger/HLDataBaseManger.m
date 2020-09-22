//
//  DataBaseManger.m
//  HeadLine
//
//  Created by admin on 2020/9/22.
//  Copyright © 2020 shelby. All rights reserved.
//

#import "DataBaseManger.h"

@implementation DataBaseManger

+ (instancetype)sharedInstance {
    static DataBaseManger *manger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [DataBaseManger new];
    });
    return manger;
}


@end
