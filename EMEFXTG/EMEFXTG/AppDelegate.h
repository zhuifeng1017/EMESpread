//
//  AppDelegate.h
//  EMESHT
//
//  Created by xuanhr on 14-10-10.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Version.h"
#import "UpdateVersionViewController.h"
#import <ShareSDK/ShareSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>
@property EMEHttpRequest *emeVersionHttpRequest;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Version *version;
@property (strong, nonatomic) UpdateVersionViewController *updateVersionViewController;

+ (void)queryAppStoreVersion;
- (void)thirdPartyLoginInfo:(SSGetUserInfoEventHandler)handler;
@end
