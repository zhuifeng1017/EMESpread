//
//  SMSAuthViewController.h
//  EMEFXTG
//
//  Created by appeme on 15/7/17.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMEViewController.h"

@interface SMSAuthViewController : EMEViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
- (IBAction)sendVerificationCodeClick:(id)sender;
- (IBAction)checkVerificationCodeClick:(id)sender;
@end
