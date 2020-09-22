//
//  HLTableViewCell.h
//  HeadLine
//
//  Created by 徐佳鹏 on 2020/9/19.
//  Copyright © 2020 shelby. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLModel;
NS_ASSUME_NONNULL_BEGIN

@interface HLTableViewCell : UITableViewCell

@property (nonatomic, assign) HLModel *model;


@end

NS_ASSUME_NONNULL_END
