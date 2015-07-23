//
//  AppMessageManager.h
//  EMESHT
//
//  Created by appeme on 14-11-14.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubMessage.h"

#define NotificationChatContentUpdate @"NotificationChatContentUpdate"
#define NotificationNoticeMessageContentUpdate @"NotificationNoticeMessageContentUpdate"

@class AppMessage;

@protocol AppMessageManagerDelegate <NSObject>
@optional
- (void)syncHistoryMessageCompleted:(BOOL)isLogin;
- (void)syncHistoryMessageFailed:(BOOL)isLogin;
@end

@interface AppMessageManager : NSObject
@property (weak, nonatomic) id<AppMessageManagerDelegate> syncDelegate;
+ (instancetype)sharedManager;
- (void)startSocketHost:(NSString *)host andPort:(unsigned short)port;
- (void)syncHistoryData:(BOOL)isLogin;
- (void)createFakeTipData;
- (AppMessage *)getAppMessageById:(NSString *)id;
- (NSArray *)getAppNotices;
- (NSArray *)getAppChats;
- (NSArray *)getAppFakeTips;
- (NSArray *)getAppCalendarsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
- (NSArray *)getAppChatsFromId:(NSString *)fromId;
- (void)removeAppFriendMessageManagerWithMsgId:(NSString *)msgId;
@end

@interface AppMessage : NSObject
@property (nonatomic, copy) NSString *id; //消息编号
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, strong) Login *from;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) SubMessageFriendActionContent *friendActionContent;
@property (nonatomic, strong) SubMessageChatContent *chat;
@property (nonatomic, strong) SubHiSendContent *hiSend;
@property (nonatomic, strong) SubMessageSystemContent *systemNotice;
@property (nonatomic, strong) SubMessageCalendarContent *calendar;
@property (nonatomic, strong) SubMessageShareArticleContent *shareArticle;
@property (nonatomic, copy) NSString *createTime; //创建时间
@end