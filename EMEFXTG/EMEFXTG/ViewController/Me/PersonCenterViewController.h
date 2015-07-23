//
//  PersonCenterViewController.h
//  EMEZL
//
//  Created by apple on 15/3/17.
//  Copyright (c) 2015年 appeme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVGloble.h"

@interface PersonCenterViewController : UIViewController
@property (weak, nonatomic) User *user;
@property (weak, nonatomic) IBOutlet UIImageView *peopleImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *dutyLabel;
@property (weak, nonatomic) IBOutlet SVGloble *globalScrollContainer;
@end
