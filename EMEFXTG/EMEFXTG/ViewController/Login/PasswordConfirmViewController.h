//
//  PasswordConfirmViewController.h
//  EMEFXTG
//
//  Created by appeme on 15/7/17.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordConfirmViewController : UIViewController
@property (copy, nonatomic) NSString *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)submitClick:(id)sender;

@end
