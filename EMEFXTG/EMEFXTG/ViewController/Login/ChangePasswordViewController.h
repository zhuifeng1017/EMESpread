//
//  ChangePasswordViewController.h
//  EMEHS-MGT
//
//  Created by appeme on 14-8-21.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMEViewController.h"

@interface ChangePasswordViewController : EMEViewController
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *outPassWord;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UIImageView *imageNeedChangeColor1;
@property (weak, nonatomic) IBOutlet UIImageView *imageNeedChangeColor2;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageNeedChangeColor3;
- (IBAction)updateClick:(id)sender;

@end
