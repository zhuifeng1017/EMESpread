//
//  AppUtils.h
//  EMESHT
//
//  Created by apple on 15/3/27.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface AppUtils : NSObject

+ (BOOL)isAppStore;
/**
 *  进入个人中心
 *
 *  @param user           
 *  @param viewController    ：  from 
 */
+ (void)gotoPersonalCenter:(User *)user viewController:(UIViewController *)viewController;
+ (void)showPersonalPopMenu:(User *)user viewController:(UIViewController *)viewController;
/**
 *  创建声音播放图像控件
 *
 *  @param type XHBubbleMessageType
 *
 *  @return 
 */
+ (UIImageView *)messageVoiceAnimationImageViewWithBubbleMessageType:(NSInteger)type;

+ (NSString *)audioCacheDir;

+ (void)showAlertView:(NSString *)title message:(NSString *)message;
+ (void)showGlobalHUD:(NSString *)text;
+ (void)showGlobalHUD:(NSString *)text duration:(NSTimeInterval)duration;

+ (void)sd_setWebImage:(UIImageView *)imageView withUrl:(NSString *)url;
+ (User *)getUserById:(NSString *)userId;

+ (NSString *)moneyFormateString:(unsigned int)money;

+ (NSString *)getAppName;
+ (NSString *)getAppDisplayName;
+ (NSString *)getAppBundleId;
+ (void)setLeftTextMargin:(UITextField *)textField withLeftMargin:(int)left ;
@end
