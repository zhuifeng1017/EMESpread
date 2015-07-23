//
//  MenuViewController.h
//  EMESHT
//
//  Created by appeme on 15/2/28.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MALTabBarViewController.h"

@interface MenuViewController : UIViewController
@property (nonatomic, weak) id<MALTabBarChinldVIewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *backColorView;
@property (weak, nonatomic) IBOutlet UIView *buttonContainer;

- (IBAction)publishGnosisClick:(id)sender;
- (IBAction)publishActivityClick:(id)sender;
- (IBAction)chatClick:(id)sender;
- (IBAction)invitationClick:(id)sender;
- (IBAction)scheduleClick:(id)sender;

@end
