//
//  AppLocalNotification.h
//  EMESHT
//
//  Created by xuanhr on 14-12-8.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppLocalNotification : NSObject
+ (instancetype)shareNotification;
- (void)registerLocalNotification;
- (void)creatLocalNotificationWithDate:(NSDate *)fireDate alertBody:(NSString *)content key:(NSString *)keyString;
- (BOOL)deleteLocalNotificationWithKey:(NSString *)key;
@end
