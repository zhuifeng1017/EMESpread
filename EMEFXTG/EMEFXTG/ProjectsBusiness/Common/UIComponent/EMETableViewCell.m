//
//  EMETableViewCell.m
//  EMEHS
//
//  Created by appeme on 14-8-15.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "EMETableViewCell.h"

@implementation EMETableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    int backgroundTag = 29001;
    if (self.selectedBackgroundView.tag != backgroundTag) {
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.07f];
        backgroundView.tag = backgroundTag;
        self.selectedBackgroundView = backgroundView;
    }
}

@end
