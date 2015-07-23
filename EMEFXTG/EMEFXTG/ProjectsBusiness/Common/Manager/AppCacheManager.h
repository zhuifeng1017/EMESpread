//
//  AppCacheManager.h
//  EMEHS-MGT
//
//  Created by appeme on 14-9-15.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <NSArray.h>
#import "Login.h"
#import "ThirdPartyShareHelper.h"

@interface AppCacheManager : NSObject
@property (readonly, copy) NSString *appCode;
@property (readonly, copy) NSString *sinaWeiboAppKey;
@property (readonly, copy) NSString *weixinAppKey;
@property (readonly, copy) NSString *weixinAppSecret;
@property (nonatomic, copy) NSString *loginUserId;
@property (nonatomic, copy) Login *loginUser;
@property (nonatomic, copy) NSString *upgradeUrl;
@property (nonatomic, copy) NSArray *addressBookArray;
@property (nonatomic, copy) NSArray *friendAddressBookArray;
@property (nonatomic) BOOL isLogin; //whether user has login
@property (nonatomic, copy) WXLogin *wxloginUser;
@property (atomic, strong) ThirdPartyShareHelper *thirdPartyShareHelper;
@property (strong, nonatomic) NSMutableArray *localNotificationArray;

@property (strong, nonatomic) NSString *wxUnionId;

+ (instancetype)sharedManager;

#pragma mark - common database values
+ (NSString *)lastMessageLoggerDownloadTimeL;
+ (void)setLastMessageLoggerDownloadTimeL:(NSString *)time;
+ (NSString *)lastCalendarLoggerDownloadTimeL;
+ (void)setLastCalendarLoggerDownloadTimeL:(NSString *)time;
+ (NSString *)hasShowCrowdFundFirstTipPage;
+ (void)setHasShowCrowdFundFirstTipPage;
@end
