//
//  SettingsViewController.m
//  EMESHT
//
//  Created by ZhaoMin on 15/3/26.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "SettingsViewController.h"
#import "ChangePasswordViewController.h"
#import "AppCacheManager.h"
#import "Version.h"
#import "UpdateVersionViewController.h"
#import "EMEPopViewController.h"
#import "EMEConfigManager.h"
#import <ShareSDK/ShareSDK.h>
#import "AppDelegate.h"
#import "AppUtils.h"


@interface SettingsViewController ()
@property (nonatomic, strong) Version *version;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    self.title = @"设置";
    [super viewDidLoad];
    _newestLabel.hidden = YES;

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fund_bj"]];

    _exitButton.layer.masksToBounds = YES;
    _exitButton.layer.cornerRadius = _exitButton.height / 2;
    
    _versionLabel.text = [NSString stringWithFormat:@"v%@", [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)needShowBackView {
    return YES;
}

- (void)showNewestLabel:(BOOL)isNewestVersion {
    _newestLabel.hidden = !isNewestVersion;
}

- (IBAction)changePwdBtnClick:(id)sender {
    ChangePasswordViewController *changePasswordViewController = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
    [self.navigationController pushViewController:changePasswordViewController animated:YES];
}

- (IBAction)checkVersionBtnClick:(id)sender {
    [self queryVersion:YES];
}

- (IBAction)techSupportBtnClick:(id)sender {
}

- (IBAction)exitBtnClick:(id)sender {
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [(UINavigationController *)window.rootViewController popToRootViewControllerAnimated:NO];

    [(UINavigationController *)window.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:^{
        [(UINavigationController *)window.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }];

    [AppCacheManager sharedManager].isLogin = NO;
    [AppCacheManager sharedManager].loginUser = nil;
    [AppCacheManager sharedManager].loginUserId = nil;

    [ShareSDK cancelAuthWithType:ShareTypeWeixiSession];
}

#pragma mark-- queryVersion
- (void)queryVersion:(BOOL)needAlreadyUpdatedVersionTip {
    
    if ([AppUtils isAppStore]) {
        [AppDelegate queryAppStoreVersion];
        return;
    }
    
    CheckVersionRequest *request = [[CheckVersionRequest alloc] init];
    request.os = @"iOS";
    request.appCode = [[EMEConfigManager shareConfigManager] getAppCode];
    request.appVerNum = [[EMEConfigManager shareConfigManager] getAppVersionNumber];

    int clientAppVersionNumber = [request.appVerNum intValue];

    EMEHttpRequest *_emeVersionHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    WEAKSELF
    [_emeVersionHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            weakSelf.version = response;
            if ([weakSelf.version.appVerNum intValue] > clientAppVersionNumber) {
                [self showNewestLabel:NO];
                if (needAlreadyUpdatedVersionTip) {
                    [weakSelf alertAlreadyUpdatedVersion];
                }
            }else if (needAlreadyUpdatedVersionTip) {
                [self showNewestLabel:YES];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"已经是最新版本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                
            }
        }
        else {
            
        }
    }];

    [_emeVersionHttpRequest sendRequest:Version.class loadingTip:NO errorTip:NO];
}

- (void)alertAlreadyUpdatedVersion {
    UpdateVersionViewController *updateVersionViewController = [[UpdateVersionViewController alloc] initWithNibName:@"UpdateVersionViewController" bundle:nil];
    updateVersionViewController.Version = _version;
    EMEPopViewController *popupViewController = [[EMEPopViewController alloc] initWithRootViewController:updateVersionViewController];
    [self.parentViewController pushViewController:popupViewController animated:YES popStyle:EMEPopStyleFromBottom];
}

@end
