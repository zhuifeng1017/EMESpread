//
//  SpreadInfoVCell.m
//  EMEFXTG
//
//  Created by Mac on 15-7-22.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "SpreadInfoVCell.h"
#import "SpreadInfoView.h"

@implementation SpreadInfoVCell

- (void)awakeFromNib {
    _infoView = [[NSBundle mainBundle] loadNibNamed:@"SpreadInfoView" owner:self options:nil][0];
    _infoView.layer.masksToBounds = YES;
    _infoView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    _infoView.layer.borderWidth = 1;
    _infoView.layer.cornerRadius = 4;
    _infoView.left = (320 - _infoView.width) / 2;
    
    [self.contentView addSubview:_infoView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
