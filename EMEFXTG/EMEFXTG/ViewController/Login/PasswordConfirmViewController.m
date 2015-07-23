//
//  PasswordConfirmViewController.m
//  EMEFXTG
//
//  Created by appeme on 15/7/17.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "PasswordConfirmViewController.h"
#import "NetApiHelper.h"
#import "User.h"
#import "AppCacheManager.h"
#import "AppUtils.h"

@interface PasswordConfirmViewController ()

@end

@implementation PasswordConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.submitButton.layer.cornerRadius = 3;
    self.submitButton.layer.masksToBounds = YES;
    
    [AppUtils setLeftTextMargin:_passwordTF withLeftMargin:10];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitClick:(id)sender {
    WeixinCompleteRequest *request = [WeixinCompleteRequest alloc];
    request.id = [AppCacheManager sharedManager].loginUserId;
    request.mobile = self.phoneNumber;
    request.password = self.passwordTF.text;

    [NetApiHelper sendRequest:request forResponse:LooseJSONModel.class loadingTip:YES errorTip:YES successTip:nil withArrayBlock:^(NSString *message, NSArray *responses) {
        if ([message isEqualToString:@"success"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}
@end
