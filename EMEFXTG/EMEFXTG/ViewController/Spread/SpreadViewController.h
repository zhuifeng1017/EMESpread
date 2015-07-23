//
//  SpreadViewController.h
//  class-timetable
//
//  Created by Mac on 15-7-17.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "SlideNavigationController.h"

@interface SpreadViewController : UIViewController
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
- (IBAction)loginBtnClick:(UIButton *)sender;
- (IBAction)shareClick:(id)sender;
- (IBAction)loginCancelBtnClick:(UIButton *)sender;
- (IBAction)removeCardClick:(id)sender;
- (IBAction)personClick:(id)sender;
- (IBAction)menuClick:(id)sender;
- (IBAction)rightMenuClick:(id)sender;
@end
