//
//  HLTableViewCell.m
//  HeadLine
//
//  Created by 徐佳鹏 on 2020/9/19.
//  Copyright © 2020 shelby. All rights reserved.
//

#import "HLTableViewCell.h"
#import "HLModel.h"
#import "UIImageView+WebCache.h"

@interface HLTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;


@end

@implementation HLTableViewCell

- (void)setModel:(HLModel *)model {
    _model = model;
    self.titleLbl.text = _model.title;
    self.contentLbl.text = _model.digest;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:_model.imgsrc]];
    
    
}


@end
