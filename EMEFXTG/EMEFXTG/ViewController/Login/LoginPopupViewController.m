//
//  LoginPopupViewController.m
//  EMESHT
//
//  Created by appeme on 15/1/16.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "LoginPopupViewController.h"
#import "EMEStableAppInfoEntity.h"
#import "EMEPopViewController.h"
#import "AppUtils.h"

@interface LoginPopupViewController () {
    LoginPopupViewBlock loginPopupViewBlock;
}
@end

@implementation LoginPopupViewController

- (void)viewDidLoad {
    self.needKeyboardAssist = YES;
    self.keyboardBaseOffsetY = 100;
    self.title = [NSString stringWithFormat:@"欢迎来到%@APP", [AppUtils getAppDisplayName]];
    [super viewDidLoad];

    //    self.innerViewContainer.layer.borderColor = [UIColor colorWithHexString:@"e0e0e0"].CGColor;
    //    self.innerViewContainer.layer.borderWidth = 1;

    self.reminderButton.selected = [[EMEStableAppInfoEntity valueForKey:@"autologin"] isEqualToString:@"1"];
    self.phoneNumber.text = [EMEStableAppInfoEntity valueForKey:@"account"];
    self.password.text = [EMEStableAppInfoEntity valueForKey:@"password"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setLoginPopupViewBlock:(LoginPopupViewBlock)block {
    loginPopupViewBlock = [block copy];
}

- (IBAction)loginClick:(id)sender {
    [EMEStableAppInfoEntity putValue:(self.reminderButton.isSelected ? @"1" : @"0")forKey:@"autologin"];

    if (_phoneNumber.text.length > 0 && _password.text.length > 0) {
        loginPopupViewBlock(_phoneNumber.text, _password.text, _reminderButton.isSelected);
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请正确填写用户名和密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (IBAction)reminderClick:(id)sender {
    _reminderButton.selected = !_reminderButton.isSelected;
}

- (IBAction)registerClick:(id)sender {
    loginPopupViewBlock(nil, nil, NO);
}
@end
