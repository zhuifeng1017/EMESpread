//
//  LoginPopupViewController.h
//  EMESHT
//
//  Created by appeme on 15/1/16.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMEViewController2.h"

typedef void (^LoginPopupViewBlock)(NSString *phone, NSString *password, BOOL rememberPassword);

@interface LoginPopupViewController : EMEViewController
@property (weak, nonatomic) IBOutlet UIView *innerViewContainer;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *reminderButton;
- (void)setLoginPopupViewBlock:(LoginPopupViewBlock)block;
- (IBAction)loginClick:(id)sender;
- (IBAction)reminderClick:(id)sender;
- (IBAction)registerClick:(id)sender;
@end
