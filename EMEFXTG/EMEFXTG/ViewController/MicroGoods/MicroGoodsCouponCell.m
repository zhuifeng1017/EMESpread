//
//  MicroGoodsCouponCell.m
//  EMEFXTG
//
//  Created by appeme on 15/6/11.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "MicroGoodsCouponCell.h"

@implementation MicroGoodsCouponCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBackgroundStyle:(long)index {
    if (index == 0) {
        _bgView.backgroundColor = [UIColor colorWithHexString:@"A9B0B7"];
        _bgView.width = _label3.right + 10;
        _label3.textColor = [UIColor darkGrayColor];
    }
    else {
        _bgView.backgroundColor = [UIColor colorWithHexString:@"DDE1E5"];
        _bgView.width = _label2.right;
        _label3.textColor = [UIColor colorWithHexString:@"FF3333"];
    }
}

@end
