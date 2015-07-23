//
//  ChangePasswordViewController.m
//  EMEHS-MGT
//
//  Created by appeme on 14-8-21.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "EMEHttpRequest.h"
#import "Login.h"
#import "UIImage+Extended.h"

@interface ChangePasswordViewController () {
    EMEHttpRequest *emeUpdateHttpRequest;
}
@property (strong, nonatomic) NSString *errorMessage;
@end

@implementation ChangePasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [_imageNeedChangeColor1 setImage:[_imageNeedChangeColor1.image imageWithTintColor:_colorView.backgroundColor]];
    [_imageNeedChangeColor2 setImage:[_imageNeedChangeColor2.image imageWithTintColor:_colorView.backgroundColor]];
    [_imageNeedChangeColor3 setImage:[_imageNeedChangeColor3.image imageWithTintColor:_colorView.backgroundColor]];
    
    _submitButton.layer.masksToBounds = YES;
    _submitButton.layer.cornerRadius = _submitButton.height / 2;
}

- (void)checkTextfieldIsNull {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:_errorMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (BOOL)fillDate {
    _errorMessage = @"";
    if (_userName.text.length == 0) {
        _errorMessage = @"请填写账号";
    } else if (_outPassWord.text.length == 0) {
        _errorMessage = @"请填写原密码";
    } else if (_passWord.text.length == 0) {
        _errorMessage = @"请填写新密码";
    }
    return [_errorMessage isEqualToString:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateClick:(id)sender {
    if (![self fillDate]) {
        [self checkTextfieldIsNull];
        return;
    }
    UpdatePasswordRequest *loginRequest = [[UpdatePasswordRequest alloc] init];
    loginRequest.loginName = _userName.text;
    loginRequest.password = _outPassWord.text;
    loginRequest.aNewPassword = _passWord.text;

    emeUpdateHttpRequest = [[EMEHttpRequest alloc] initWithRequest:loginRequest];
    __weak ChangePasswordViewController *weakSelf = self;

    [emeUpdateHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            __block UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"修改密码成功" delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertView dismissWithClickedButtonIndex:0 animated:YES];
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        } else {
        }
    }];

    [emeUpdateHttpRequest sendRequest:Login.class loadingTip:YES errorTip:YES];

    [self hideKeyboard];
}
@end
