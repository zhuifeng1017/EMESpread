//
//  MicroGoodsCell.m
//  EMEFXTG
//
//  Created by appeme on 15/6/9.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "MicroGoodsCell.h"

@implementation MicroGoodsCell

- (void)awakeFromNib {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.toLookLabel.underlineStyle = kCTUnderlineStyleSingle;
        self.toLookLabel.verticalTextAlignment = NIVerticalTextAlignmentMiddle;
    });
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
