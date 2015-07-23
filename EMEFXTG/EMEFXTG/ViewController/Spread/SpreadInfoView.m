//
//  SpreadInfoView.m
//  class-timetable
//
//  Created by Mac on 15-7-17.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import "SpreadInfoView.h"

@implementation SpreadInfoView
- (void)awakeFromNib {
    for (UILabel *label in _levelLabels) {
        [label toCircle];
    }
    
    _levelDetailLabel.layer.cornerRadius = 4;
    _levelDetailLabel.layer.masksToBounds = YES;
}

@end
