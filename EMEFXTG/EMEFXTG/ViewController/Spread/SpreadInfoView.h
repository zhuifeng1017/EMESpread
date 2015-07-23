//
//  SpreadInfoView.h
//  class-timetable
//
//  Created by Mac on 15-7-17.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpreadInfoView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *shareNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *rewardLabel;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *levelLabels;
@property (weak, nonatomic) IBOutlet UILabel *levelDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *tmpLabel;
@end
