//
//  SpreadItemCell.h
//  EMEFXTG
//
//  Created by apple on 15/7/22.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRateView.h"
@interface SpreadItemCell : UITableViewCell

@end

/**
 *  SpreadScoreCell
 */
@interface SpreadScoreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet DYRateView *rateView;

- (void)setStars:(float)stars;
@end
