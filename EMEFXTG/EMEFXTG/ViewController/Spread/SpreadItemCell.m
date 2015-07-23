//
//  SpreadItemCell.m
//  EMEFXTG
//
//  Created by apple on 15/7/22.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "SpreadItemCell.h"

@implementation SpreadItemCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

@implementation SpreadScoreCell
- (void)awakeFromNib {
    [self.rateView setFullStarImage:[UIImage imageNamed:@"rate_start1.png"]];
    [self.rateView setEmptyStarImage:[UIImage imageNamed:@"rate_start2.png"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setStars:(float)stars {
    [self.rateView setRate:stars];
}
@end
