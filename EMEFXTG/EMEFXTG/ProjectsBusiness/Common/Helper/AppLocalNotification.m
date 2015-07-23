//
//  AppLocalNotification.m
//  EMESHT
//
//  Created by xuanhr on 14-12-8.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "AppLocalNotification.h"

@implementation AppLocalNotification
+ (instancetype)shareNotification {
    static AppLocalNotification *appNotification;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appNotification = [[AppLocalNotification alloc] init];
    });

    return appNotification;
}

- (void)registerLocalNotification {
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil]];
    }
}

- (void)showAlertViewForLocalNotificationWithContent:(NSString *)content {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:content message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)creatLocalNotificationWithDate:(NSDate *)fireDate alertBody:(NSString *)content key:(NSString *)keyString {
    // 如果对应key已经存在则删除key
    [self deleteLocalNotificationWithKey:keyString];
    // 创建一个本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    //设置10秒之后
    if (notification != nil) {
        // 设置推送时间
        notification.fireDate = fireDate;
        // 设置时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 设置重复间隔
        //        notification.repeatInterval = 0;
        // 推送声音
        //        notification.soundName = UILocalNotificationDefaultSoundName;
        // 推送内容
        notification.alertBody = [NSString stringWithFormat:@"您有新的安排提醒：%@",content];
        //显示在icon上的红色圈中的数子
        notification.applicationIconBadgeNumber = 1;
        //设置userinfo 方便在之后需要撤销的时候使用
        NSDictionary *info = [NSDictionary dictionaryWithObject:keyString forKey:@"key"];
        notification.userInfo = info;
        //添加推送到UIApplication
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:notification];
    }
}

- (BOOL)deleteLocalNotificationWithKey:(NSString *)key {
    // 获得 UIApplication
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArray = [app scheduledLocalNotifications];
    //声明本地通知对象
    UILocalNotification *localNotification;
    if (localArray) {
        for (UILocalNotification *noti in localArray) {
            NSDictionary *dict = noti.userInfo;
            if (dict) {
                NSString *inKey = [dict objectForKey:@"key"];
                if ([inKey isEqualToString:key]) {
                    if (localNotification) {
                        localNotification = nil;
                    }
                    break;
                }
            }
        }

        //判断是否找到已经存在的相同key的推送
        if (!localNotification) {
            //不存在初始化
            localNotification = [[UILocalNotification alloc] init];
            return NO;
        }

        if (localNotification) {
            //不推送 取消推送
            [app cancelLocalNotification:localNotification];
            return YES;
        }
    }
    return NO;
}

@end
