//
//  CircleProgressView.h
//  EMESHT
//
//  Created by appeme on 15/3/24.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIAttributedLabel.h"

@interface CircleProgressView : UIView
@property (strong, nonatomic) NIAttributedLabel *label;
@property (assign, nonatomic) int progress; //0~100
@property (assign, nonatomic) int lineWidth;
- (void)refresh;
@end
