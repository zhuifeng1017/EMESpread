//
//  AppCacheManager.m
//  EMEHS-MGT
//
//  Created by appeme on 14-9-15.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "AppCacheManager.h"
#import "EMEAppInfoEntity.h"
#import "EMEConfigManager.h"

static NSString *lastMessageLoggerDownloadTimeL = @"lastMessageLoggerDownloadTimeL"; //long long
static NSString *lastCalendarLoggerDownloadTimeL = @"lastCalendarLoggerDownloadTimeL"; //long long
static NSString *hasShowCrowdFundFirstTipPage = @"hasShowCrowdFundFirstTipPage";

@implementation AppCacheManager

+ (instancetype)sharedManager {
    static AppCacheManager *appCacheManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appCacheManager = [[AppCacheManager alloc] init];
        [appCacheManager configureConstant];
        [appCacheManager configureObject];
    });

    return appCacheManager;
}

- (void)configureConstant {
    _sinaWeiboAppKey = @"568898243";
    _weixinAppKey = @"wx55b4165e0410da41" ; // @"wx6f7a8780b5e6dcde";
    _weixinAppSecret = @"232a90b69b1a176d5f5cec1bc5d93157";
}

- (void)configureObject {
    _thirdPartyShareHelper = [[ThirdPartyShareHelper alloc] init];
    _localNotificationArray = [NSMutableArray array];
}

- (NSString *)appCode {
    NSString *appCode = [[EMEConfigManager shareConfigManager] getAppCode];
    return appCode;
}

#pragma mark - common database values
+ (NSString *)lastMessageLoggerDownloadTimeL {
    NSString *userLastMessageLoggerKey = [NSString stringWithFormat:@"%@_%@", lastMessageLoggerDownloadTimeL, [AppCacheManager sharedManager].loginUserId];
    NSString *time = [EMEAppInfoEntity valueForKey:userLastMessageLoggerKey];
    return time;
}

+ (void)setLastMessageLoggerDownloadTimeL:(NSString *)time {
    NSString *userLastMessageLoggerKey = [NSString stringWithFormat:@"%@_%@", lastMessageLoggerDownloadTimeL, [AppCacheManager sharedManager].loginUserId];
    [EMEAppInfoEntity putValue:time forKey:userLastMessageLoggerKey];
}

+ (NSString *)lastCalendarLoggerDownloadTimeL {
    NSString *userLastMessageLoggerKey = [NSString stringWithFormat:@"%@_%@", lastCalendarLoggerDownloadTimeL, [AppCacheManager sharedManager].loginUserId];
    NSString *time = [EMEAppInfoEntity valueForKey:userLastMessageLoggerKey];
    return time;
}

+ (void)setLastCalendarLoggerDownloadTimeL:(NSString *)time {
    NSString *userLastMessageLoggerKey = [NSString stringWithFormat:@"%@_%@", lastCalendarLoggerDownloadTimeL, [AppCacheManager sharedManager].loginUserId];
    [EMEAppInfoEntity putValue:time forKey:userLastMessageLoggerKey];
}

+ (NSString *)hasShowCrowdFundFirstTipPage {
    NSString *time = [EMEAppInfoEntity valueForKey:hasShowCrowdFundFirstTipPage];
    return time;
}

+ (void)setHasShowCrowdFundFirstTipPage {
    [EMEAppInfoEntity putValue:@"YES" forKey:hasShowCrowdFundFirstTipPage];
}

@end
