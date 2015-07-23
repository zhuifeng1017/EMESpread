//
//  SMSAuthViewController.m
//  EMEFXTG
//
//  Created by appeme on 15/7/17.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "SMSAuthViewController.h"
#import <SMS_SDK/SMS_SDK.h>
#import "AppUtils.h"
#import "PasswordConfirmViewController.h"

@interface SMSAuthViewController ()

@end

@implementation SMSAuthViewController

- (void)viewDidLoad {
    self.needKeyboardAssist = YES;
    [super viewDidLoad];

    self.nextButton.layer.cornerRadius = 3;
    self.nextButton.layer.masksToBounds = YES;
    
    [AppUtils setLeftTextMargin:_phoneTF withLeftMargin:10];
    [AppUtils setLeftTextMargin:_verificationCodeTF withLeftMargin:10];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//发送验证码
- (IBAction)sendVerificationCodeClick:(id)sender {
    if (![_phoneTF.text isVAlidPhoneNumber]) {
        [AppUtils showAlertView:@"" message:@"请填写正确的手机号码"];
        return;
    }
    
    [SMS_SDK getVerificationCodeBySMSWithPhone:_phoneTF.text zone:@"86" result:^(SMS_SDKError *error) {
        if (error) {
            [AppUtils showAlertView:@"%@" message:error.localizedDescription];
        }
    }];
}

- (IBAction)checkVerificationCodeClick:(id)sender {
    //判断验证码是否还有效
    if (![_verificationCodeTF.text isValid]) {
        [AppUtils showAlertView:@"" message:@"请填写验证码"];
        return;
    }

    WEAKSELF;
    [SMS_SDK commitVerifyCode:_verificationCodeTF.text result:^(enum SMS_ResponseState state) {
        if (state == SMS_ResponseStateSuccess) {
            PasswordConfirmViewController *vc = [[PasswordConfirmViewController alloc] init];
            vc.phoneNumber = weakSelf.verificationCodeTF.text;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            [AppUtils showAlertView:@"" message:@"请填写正确的验证码"];
        }
    }];
}
@end
