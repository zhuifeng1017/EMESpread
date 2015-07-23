//
//  AppDelegate.m
//  EMESHT
//
//  Created by xuanhr on 14-10-10.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "AppDelegate.h"
#import "SVGloble.h"
#import "EMEDatabaseManager.h"
#import "MALTabBarViewController.h"
#import "EMENavigationBar.h"
#import "EMEThemeManager.h"
#import "AppMessageManager.h"
#import "SecretScreenViewController.h"
//#import "DurexKit.h"
#import "Harpy.h"
#import "Version.h"
#import "EMEConfigManager.h"
#import "AppVersionPopViewController.h"
#import "EMEPopViewController.h"
#import "UpdateVersionViewController.h"
#import "EMEStableInfoDatabaseManager.h"
#import <ShareSDK/ShareSDK.h>
#import <SMS_SDK/SMS_SDK.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "AppLocalNotification.h"
#import "AppCacheManager.h"
#import "AppUtils.h"
#import "HomeTabBarViewController.h"
#import "NSURL+Param.h"
#import "SpreadViewController.h"
#import "EMEViewController.h"
#import "SlideNavigationController.h"
#import "LeftMenuViewController.h"
#import "RightMenuViewController.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SpreadWelcomeViewController.h"

//SHT
//#define ShareSDKAppKey @"4f83ed3cc726"
//#define ShareSDKAppSecret @"421249240e4b7593edba0f8b7e5af695"
//DEMO
#define ShareSDKAppKey @"5b2655c71290"
#define ShareSDKAppSecret @"55988074b9a3faadffa6f74cd3ae7845"

@interface AppDelegate ()
@property (copy, nonatomic) SSGetUserInfoEventHandler getUserInfoEventHandler;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    application.applicationIconBadgeNumber = 0;

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

    [EMEThemeManager sharedManager];
    [EMEDatabaseManager sharedInstance];
    [EMEStableInfoDatabaseManager sharedInstance];
    [SecretScreenHelper loadStoredServerConfigFile];
    [EMEHttpRequest enableLog:YES];
    [EMENavigationBar setDefaultNavBarStatusBackgroundColor:[UIColor blackColor]];
    [EMENavigationBar setDefaultBackIcon:@"fund_back" highlightedIcon:nil];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [SVGloble shareInstance].globleWidth = screenRect.size.width;        //屏幕宽度
    [SVGloble shareInstance].globleHeight = screenRect.size.height - 20; //屏幕高度（无顶栏）
    [SVGloble shareInstance].globleAllHeight = screenRect.size.height;   //屏幕高度（有顶栏）

    SpreadViewController *homeVC = [[SpreadViewController alloc] init];
    SlideNavigationController *rootNavigationController = [[SlideNavigationController alloc] initWithRootViewController:homeVC];
    self.window.rootViewController = rootNavigationController;

    LeftMenuViewController *leftMenuController = [[LeftMenuViewController alloc] initWithNibName:@"LeftMenuViewController" bundle:nil];
    RightMenuViewController *rightMenuController = [[RightMenuViewController alloc] initWithNibName:@"RightMenuViewController" bundle:nil];
    [SlideNavigationController sharedInstance].enableSwipeGesture = NO;
    [SlideNavigationController sharedInstance].leftMenu = leftMenuController;
    [SlideNavigationController sharedInstance].rightMenu = rightMenuController;
    [SlideNavigationController sharedInstance].portraitSlideOffset = 70;
    [SlideNavigationController sharedInstance].landscapeSlideOffset = [SlideNavigationController sharedInstance].portraitSlideOffset;

    if ([FWUICommon OSVersion] >= 8) {
        [SlideNavigationController sharedInstance].menuRevealAnimator = [[SlideNavigationContorllerAnimatorSlide alloc] init];
    }

    if (![AppUtils isAppStore]) {
        [self queryVersion:YES];
    }

    [self configureShareLib];

    return YES;
}

+ (void)queryAppStoreVersion {
    [[Harpy sharedInstance] setAppID:@"888623482"];
    [[Harpy sharedInstance] setAppName:@"神马城"];
    [[Harpy sharedInstance] setAlertType:HarpyAlertTypeOption];
    [[Harpy sharedInstance] setCountryCode:@"CN"];
    [[Harpy sharedInstance] setPresentingViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    [[Harpy sharedInstance] setForceLanguageLocalization:HarpyLanguageChineseSimplified];

    [[Harpy sharedInstance] checkVersion];
}

- (void)queryVersion:(BOOL)needAlreadyUpdatedVersionTip {
    CheckVersionRequest *request = [[CheckVersionRequest alloc] init];
    request.os = @"iOS";
    request.appCode = [[EMEConfigManager shareConfigManager] getAppCode];
    request.appVerNum = [[EMEConfigManager shareConfigManager] getAppVersionNumber];

    int clientAppVersionNumber = [request.appVerNum intValue];

    _emeVersionHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    //    __weak AppDelegate *weakSelf = self;
    WEAKSELF;

    [_emeVersionHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            weakSelf.version = response;
            [AppCacheManager sharedManager].upgradeUrl = weakSelf.version.appUrl;
            
            if ([weakSelf.version.appVerNum intValue] > clientAppVersionNumber) {
                
                if (needAlreadyUpdatedVersionTip) {
                    [weakSelf alertAlreadyUpdatedVersion];
                }
            }
            else if (needAlreadyUpdatedVersionTip) {
                //            [weakSelf alertAlreadyUpdatedVersion];
            }
        }
        else {
        }
    }];

    [_emeVersionHttpRequest sendRequest:Version.class loadingTip:NO errorTip:NO];
}

- (void)alertAlreadyUpdatedVersion {
    if (_updateVersionViewController) {
        return;
    }
    self.window.rootViewController.view.userInteractionEnabled = NO;
    _updateVersionViewController = [[UpdateVersionViewController alloc] initWithNibName:@"UpdateVersionViewController" bundle:nil];
    _updateVersionViewController.version = _version;
    EMEPopViewController *popupViewController = [[EMEPopViewController alloc] initWithRootViewController:_updateVersionViewController];
    [self.window.rootViewController pushViewController:popupViewController animated:YES popStyle:EMEPopStyleFromBottom];
    self.window.rootViewController.view.userInteractionEnabled = YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
    case 0:
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", _version.appUrl]]];
        break;

    default:
        break;
    }
}

- (void)configureShareLib {
    [ShareSDK registerApp:@"4f83ed3cc726"]; //字符串api20为您的ShareSDK的AppKey

    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:[AppCacheManager sharedManager].sinaWeiboAppKey
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn"];

    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK connectSinaWeiboWithAppKey:[AppCacheManager sharedManager].sinaWeiboAppKey
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn"
                             weiboSDKCls:[WeiboSDK class]];

    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:[AppCacheManager sharedManager].weixinAppKey
                           appSecret:[AppCacheManager sharedManager].weixinAppSecret
                           wechatCls:[WXApi class]];

    [ShareSDK connectSMS];

    // [ShareSDK cancelAuthWithType:ShareTypeWeixiSession];

    //初始化应用，appKey和appSecret从后台申请得到
    [SMS_SDK registerApp:ShareSDKAppKey withSecret:ShareSDKAppSecret];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self queryVersion:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([[url scheme] isEqualToString:@"eme-spread"]) {
        [self handleOpenURL:url];
        return YES;
    } else {
        return [ShareSDK handleOpenURL:url wxDelegate:self];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([[url scheme] isEqualToString:@"eme-spread"]) {
        [self handleOpenURL:url];
        return YES;
    } else {
        return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
    }
}

- (void)handleOpenURL:(NSURL *)url {
    //eme-spread://spread/launch?content_id=xx&from_id=xx&to_id=xx
    if ([[url absoluteString] hasPrefix:@"eme-spread://spread/launch"]) {
        NSDictionary *dict = url.parameters;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"viewProductNotification" object:nil userInfo:dict];
    }
}

- (void)onReq:(BaseReq *)req {
}

- (void)onResp:(BaseResp *)resp {
}

- (void)thirdPartyLoginInfo:(SSGetUserInfoEventHandler)handler {
    self.getUserInfoEventHandler = handler;

    dispatch_async(dispatch_get_main_queue(), ^{
    
        id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                             allowCallback:YES
                                                             authViewStyle:SSAuthViewStyleFullScreenPopup
                                                              viewDelegate:nil
                                                   authManagerViewDelegate:nil];
        
        //在授权页面中添加关注官方微博
        [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                        SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                        [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                        SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                        nil]];
        
        WEAKSELF;
        [ShareSDK getUserInfoWithType:ShareTypeWeixiSession
                          authOptions:authOptions
                               result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                                   
                                   weakSelf.getUserInfoEventHandler(result, userInfo, error);
                                   
                               }];
    });
}

@end
