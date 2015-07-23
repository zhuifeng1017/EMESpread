//
//  AppMessageManager.m
//  EMESHT
//
//  Created by appeme on 14-11-14.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "AppMessageManager.h"
#import "AppCacheManager.h"
#import "EMEDatabaseManager.h"
#import "Message.h"
#import "NoticeMessageEntity.h"
#import "EMEAppInfoEntity.h"
#import "EMEStableAppInfoEntity.h"
#import "MBProgressHUD.h"
#import "AppSocketMessageManager.h"
#import "NetApiChatGroupHelper.h"
#import "ChatGroupNewInfoEntity.h"
//#import "NoticeTrendViewController.h"
#import "EMEHttpBatchRequest.h"
#import "AllUserEntity.h"
#import "EMEConfigManager.h"

typedef NS_ENUM(NSInteger, AppMessageManagerType) {
    AppMessageManagerTypeChat,
    AppMessageManagerTypeNotice,
    AppMessageManagerTypeCalendar
};

typedef NS_ENUM(NSInteger, DownloadLoggerType) {
    DownloadLoggerTypeMessage,
    DownloadLoggerTypeCalendar
};

@implementation AppMessage
@end

@interface AppMessageManager () <AppSocketMessageDelegate> {
    BOOL isStart;   //whether AppMessageManager is start
    NSTimer *timer; //app message looper timer
}
@property (assign, nonatomic) BOOL firstLoginForTheUser; // whether the user is first login, if yes he should download
@property (assign, nonatomic) BOOL syncHistoryMessageForLogin;
@property (strong, nonatomic) EMEHttpRequest *emeHttpRequest;
@property (strong, nonatomic) EMEHttpBatchRequest *emeHttpAllUserRequest;
@property (strong, nonatomic) MBProgressHUD *syncProgress;
@property (assign, nonatomic) DownloadLoggerType downloadedDataLoggerType;
@property (strong, nonatomic) AppSocketMessageManager *appSocketMessageManager;

@property (copy, nonatomic) NSNumber *lastMessageLoggerDownloadTimeL;
@property (assign, nonatomic) long long maxLastMessageLoggerDownloadTimeL;
@property (assign, nonatomic) int downloadedMessageLoggerPage; //current downloaded message logger page

@property (copy, nonatomic) NSNumber *lastCalendarLoggerDownloadTimeL;
@property (assign, nonatomic) long long maxLastCalendarLoggerDownloadTimeL;
@property (assign, nonatomic) int downloadedCalendarLoggerPage; //current downloaded calendar logger pagecalendar logger
@end

@implementation AppMessageManager
+ (instancetype)sharedManager {
    static AppMessageManager *appMessageManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appMessageManager = [[AppMessageManager alloc] init];
        appMessageManager.maxLastMessageLoggerDownloadTimeL = -1;

        [[NSNotificationCenter defaultCenter] addObserver:appMessageManager selector:@selector(applicationWillEnterForeground) name:NoticeApplicationWillEnterForeground object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:appMessageManager selector:@selector(applicationWillEnterBackground) name:NoticeApplicationWillEnterBackground object:nil];
    });

    return appMessageManager;
}

- (void)applicationWillEnterForeground {
    [self syncHistoryData:NO];
}

- (void)applicationWillEnterBackground {
    [self.appSocketMessageManager closeSocket];
}

- (void)startSocketHost:(NSString *)host andPort:(unsigned short)port {
    self.appSocketMessageManager = [[AppSocketMessageManager alloc] initHost:host andPort:port];
    self.appSocketMessageManager.delegate = self;
}

- (void)receivedAppSocketMessage:(NSString *)jsonMessage {
    EMEHttpResponseHelper *requestHelper = [[EMEHttpResponseHelper alloc] initRequest:nil withData:jsonMessage autoHideLoadingTipAfterCompletion:YES showErrorTip:NO];
    if (requestHelper.rsflag) {
        NSDictionary *rs = requestHelper.resultDictionary;

        if (rs.count > 0) {
            JSONModelError *error = nil;
            MessageLogger *messageLogger = [[MessageLogger alloc] initWithDictionary:rs error:&error];

            [self processHistoryMessageData:@[ messageLogger ] needBroadcast:YES];
        }
    }
}

//sync message and calendar by two request
- (void)syncHistoryData:(BOOL)isLogin {
    if (![AppCacheManager sharedManager].isLogin) {
        return;
    }

    self.syncHistoryMessageForLogin = isLogin;
    [self queryAllUserRequest];
    
    //DRAFT hchai, needn't sync history on own server, 20150428
    if (self.syncDelegate) {
        [self.syncDelegate syncHistoryMessageCompleted:self.syncHistoryMessageForLogin];
    }
    return;
    
    

    NSString *hasInsertFakeTip = [EMEStableAppInfoEntity valueForKey:@"hasInsertFakeTip"];
    if (!hasInsertFakeTip) {
        [self createFakeTipData];
        [EMEStableAppInfoEntity putValue:@"YES" forKey:@"hasInsertFakeTip"];
    }

    // read lastMessageLoggerDownloadTimeL from database
    NSString *time = [AppCacheManager lastMessageLoggerDownloadTimeL];
    self.lastMessageLoggerDownloadTimeL = [[NSNumber alloc] initWithLongLong:-1];
    if (time) {
        self.lastMessageLoggerDownloadTimeL = [[NSNumber alloc] initWithLongLong:[time longLongValue]];
    }

    // download MessageLogger
    NSString *calendarTime = [AppCacheManager lastCalendarLoggerDownloadTimeL];
    self.lastCalendarLoggerDownloadTimeL = [[NSNumber alloc] initWithLongLong:-1];

    self.firstLoginForTheUser = YES;
    if (calendarTime) {
        self.lastCalendarLoggerDownloadTimeL = [[NSNumber alloc] initWithLongLong:[calendarTime longLongValue]];

        if ([calendarTime isEqualToString:@"done"]) {
            self.firstLoginForTheUser = NO;
        }
    }

    [self queryAllUserRequest];
    [self syncHistoryData];
}

- (void)syncHistoryData {
    if (self.syncHistoryMessageForLogin) {
        [self createAndShowProgressHUD:@"开始同步..."];
    }

    self.downloadedDataLoggerType = DownloadLoggerTypeMessage;
    self.downloadedMessageLoggerPage = 0;
    self.downloadedCalendarLoggerPage = 0;

    [self queryMessageLoggerRequest];
}

- (void)createAndShowProgressHUD:(NSString *)label {
    UIView *view = [[UIApplication sharedApplication] keyWindow];
    self.syncProgress = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.syncProgress.mode = MBProgressHUDModeIndeterminate;
    self.syncProgress.labelText = label;
    [self.syncProgress show:YES];
}

- (void)hideProgressHUD {
    UIView *view = [[UIApplication sharedApplication] keyWindow];
    [MBProgressHUD hideHUDForView:view animated:YES];
    self.syncProgress = nil;
}

- (NSArray *)getAppMessages:(NSString *)condition {
    NSArray *messages = [[[EMEDatabaseManager sharedInstance] noticeMessageDatabase] selectAll:condition];

    NSMutableArray *appMessages = [NSMutableArray array];
    for (int i = 0; i < [messages count]; i++) {
        NoticeMessageEntity *noticeMessageEntity = messages[i];

        AppMessage *appMessage = [self convertToAppMessage:noticeMessageEntity];
        if (appMessage) {
            [appMessages addObject:appMessage];
        }
    }

    return [appMessages copy];
}

- (AppMessage *)getAppMessageById:(NSString *)id {
    NSArray *apps = [self getAppMessages:[NSString stringWithFormat:@"id='%@'", id]];
    if (apps.count > 0) {
        return apps[0];
    }
    return nil;
}

- (AppMessage *)getAppMessageByGroupId:(NSString *)id {
    NSArray *apps = [self getAppMessages:[NSString stringWithFormat:@"id='%@'", id]];
    if (apps.count > 0) {
        return apps[0];
    }
    return nil;
}

- (NSArray *)getAppNotices {
    return [self getAppMessagesByType:AppMessageManagerTypeNotice];
}

- (NSArray *)getAppChats {
    return [self getAppMessagesByType:AppMessageManagerTypeChat];
}

- (NSArray *)getAppCalendarsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    NSString *whereDate = @"";
    if (fromDate && toDate) {
        whereDate = [NSString stringWithFormat:@"and (createtime >= '%@' and createtime <= '%@')", [fromDate formattedDateWithDefaultFormat], [toDate formattedDateWithDefaultFormat]];
    } else if (fromDate) {
        whereDate = [NSString stringWithFormat:@"and createtime >= '%@'", [fromDate formattedDateWithDefaultFormat]];
    } else if (toDate) {
        whereDate = [NSString stringWithFormat:@"and createtime <= '%@'", [toDate formattedDateWithDefaultFormat]];
    }

    NSString *condition = [NSString stringWithFormat:@"uid = '%@' and tag like 'calendar%%' %@ order by createtime", [AppCacheManager sharedManager].loginUserId, whereDate];

    return [self getAppMessages:condition];
}

- (NSArray *)getAppChatsFromId:(NSString *)fromId {
    NSString *condition = [NSString stringWithFormat:@"uid = '%@' and fromid = '%@' and tag = 'chat' order by createtime", [AppCacheManager sharedManager].loginUserId, fromId];
    return [self getAppMessages:condition];
}

- (NSArray *)getAppFakeTips {
    NSString *condition = [NSString stringWithFormat:@"uid = '%@' and id like 'system-fake-tip%%' and tag = 'sys_msg' order by createtime", [AppCacheManager sharedManager].loginUserId];
    return [self getAppMessages:condition];
}

- (void)removeAppFriendMessageManagerWithMsgId:(NSString *)msgId {
    [[[EMEDatabaseManager sharedInstance] noticeMessageDatabase] deleteAll:[NSString stringWithFormat:@"id = '%@'", msgId]];
}

#pragma mark - processMessageData
/**
 * write message to database and broadcast to listeners
 */
- (void)processHistoryMessageData:(NSArray *)messageLoggerArray needBroadcast:(BOOL)needBroadcast {
    if (messageLoggerArray.count < 1) {
        // hasn't new data
        return;
    }

    NSMutableArray *messageArray = [NSMutableArray array];

    for (int i = 0; i < messageLoggerArray.count; i++) {
        MessageLogger *message = messageLoggerArray[i];

        if (self.downloadedDataLoggerType == DownloadLoggerTypeMessage) {
            if (self.firstLoginForTheUser && [message.tag hasPrefix:@"calendar"]) {
                // needn't store calendar from MessageLogger for first login
                continue;
            }
        }

        NoticeMessageEntity *messageEntity = [[NoticeMessageEntity alloc] init];
        messageEntity.id = message.id;
        messageEntity.uId = message.uId;
        messageEntity.tag = message.tag;
        messageEntity.title = message.title;
        messageEntity.msgFrom = (message.from && message.from.count > 0) ? [FWXml2Json dictionaryToJson:message.from] : nil;
        messageEntity.message = (message.msg && message.msg.count > 0) ? [FWXml2Json dictionaryToJson:message.msg] : nil;
        messageEntity.desc = message.desc ? [FWXml2Json dictionaryToJson:message.desc] : nil;
        messageEntity.createTime = message.createTime;

        if (message.from[@"id"]) {
            messageEntity.fromId = message.from[@"id"];
        }
        [self fillEntityFromId:messageEntity fromMessage:message.msg];

        [messageArray addObject:messageEntity];

        if (self.downloadedDataLoggerType == DownloadLoggerTypeMessage) {
            // update lastMessageLoggerDownloadTimeL;
            if ([message.createTimeL longLongValue] > self.maxLastMessageLoggerDownloadTimeL) {
                self.maxLastMessageLoggerDownloadTimeL = [message.createTimeL longLongValue];
                [AppCacheManager setLastMessageLoggerDownloadTimeL:[NSString stringWithFormat:@"%lld", self.maxLastMessageLoggerDownloadTimeL]];
            }
        } else {
            // update lastCalendarLoggerDownloadTimeL
            if ([message.createTimeL longLongValue] > self.maxLastCalendarLoggerDownloadTimeL) {
                self.maxLastCalendarLoggerDownloadTimeL = [message.createTimeL longLongValue];
                [AppCacheManager setLastCalendarLoggerDownloadTimeL:[NSString stringWithFormat:@"%lld", self.maxLastCalendarLoggerDownloadTimeL]];
            }
        }
    }

    if (messageArray.count > 0) {
        // store data into DB
        [[[EMEDatabaseManager sharedInstance] noticeMessageDatabase] insertArray:messageArray];
    }

    // calculate new info in chat group
    for (int i = 0; i < messageArray.count; i++) {
        NoticeMessageEntity *messageEntity = messageArray[i];
        if ([messageEntity.tag isEqual:@"chat"]) {

            AppMessage *appMessage = [self convertToAppMessage:messageEntity];
            if (!appMessage) {
                continue;
            }

            NSString *condition = [NSString stringWithFormat:@"id = '%@' and uId = '%@' and type = 'chat'", appMessage.chat.group.id, [AppCacheManager sharedManager].loginUserId];
            ChatGroupNewInfoEntity *readChatGroupNewInfoEntity = (ChatGroupNewInfoEntity *)[[[EMEDatabaseManager sharedInstance].chatGroupNewInfoDatabase selectAll:condition] firstObject];

            BOOL filteted = [appMessage.chat.from.id isEqualToString:appMessage.chat.to.id];
            if (filteted) {
                continue;
            }

            if (readChatGroupNewInfoEntity) {
                readChatGroupNewInfoEntity.freshInfoCount = [NSString stringWithFormat:@"%d", [readChatGroupNewInfoEntity.freshInfoCount intValue] + 1];
            } else {
                readChatGroupNewInfoEntity = [[ChatGroupNewInfoEntity alloc] init];
                readChatGroupNewInfoEntity.id = appMessage.chat.group.id;
                readChatGroupNewInfoEntity.type = @"chat";
                readChatGroupNewInfoEntity.uId = [AppCacheManager sharedManager].loginUserId;
                readChatGroupNewInfoEntity.freshInfoCount = @"1";
            }

            [[EMEDatabaseManager sharedInstance].chatGroupNewInfoDatabase insert:readChatGroupNewInfoEntity];
        }
    }

    // broadcast
    if (needBroadcast) {
        [self broadcastMessage:messageArray];
    }
}

#pragma mark - convert to AppMessage
- (NSArray *)getAppMessagesByType:(AppMessageManagerType)type {
    NSString *condition = nil;
    if (type == AppMessageManagerTypeNotice) {
        condition = [NSString stringWithFormat:@"(uid = '-1' or uid = '%@') and tag <> 'chat' order by createtime", [AppCacheManager sharedManager].loginUserId];
    } else if (type == AppMessageManagerTypeChat) {
        condition = [NSString stringWithFormat:@"uid = '%@' and tag = 'chat' order by createtime", [AppCacheManager sharedManager].loginUserId];
    } else if (type == AppMessageManagerTypeCalendar) {
        condition = [NSString stringWithFormat:@"uid = '%@' and tag like 'calendar%%' order by createtime", [AppCacheManager sharedManager].loginUserId];
    }

    return [self getAppMessages:condition];
}

- (AppMessage *)convertToAppMessage:(NoticeMessageEntity *)noticeMessageEntity {
    AppMessage *appMessage = nil;
    @try {
        appMessage = [[AppMessage alloc] init];
        appMessage.id = noticeMessageEntity.id;
        appMessage.tag = noticeMessageEntity.tag;
        appMessage.title = noticeMessageEntity.title;
        appMessage.desc = noticeMessageEntity.desc;
        appMessage.createTime = noticeMessageEntity.createTime;

        if (noticeMessageEntity.msgFrom.length > 0) {
            appMessage.from = [[Login alloc] initWithString:noticeMessageEntity.msgFrom error:nil];
        }

        if ([appMessage.tag isEqualToString:@"chat"]) {
            SubMessageChatContent *subMessageChatContent = [[SubMessageChatContent alloc] initWithString:noticeMessageEntity.message error:nil];
            appMessage.chat = subMessageChatContent;
        } else if ([appMessage.tag hasPrefix:@"chat_apply_friend"]) {
            SubMessageFriendActionContent *subMessageFriendActionContent = [[SubMessageFriendActionContent alloc] initWithString:noticeMessageEntity.message error:nil];
            appMessage.friendActionContent = subMessageFriendActionContent;
        } else if ([appMessage.tag isEqualToString:@"hi"]) {
            SubHiSendContent *subHiSendContent = [[SubHiSendContent alloc] initWithString:noticeMessageEntity.message error:nil];
            appMessage.hiSend = subHiSendContent;
        } else if ([appMessage.tag isEqualToString:@"sys_msg"]) {
            SubMessageSystemContent *subMessageSystemContent = [[SubMessageSystemContent alloc] initWithString:noticeMessageEntity.message error:nil];
            appMessage.systemNotice = subMessageSystemContent;
        } else if ([appMessage.tag hasPrefix:@"calendar"]) {
            SubMessageCalendarContent *subMessageChatContent = [[SubMessageCalendarContent alloc] initWithString:noticeMessageEntity.message error:nil];
            appMessage.calendar = subMessageChatContent;
        } else if ([appMessage.tag isEqualToString:@"share_article"]) {
            SubMessageShareArticleContent *subMessageShareArticleContent = [[SubMessageShareArticleContent alloc] initWithString:noticeMessageEntity.message error:nil];
            appMessage.shareArticle = subMessageShareArticleContent;
        }
    }
    @catch (NSException *exception) {
        NSLog_e(@"%@", exception);
    }
    @finally {
    }

    return appMessage;
}

- (void)fillEntityFromId:(NoticeMessageEntity *)messageEntity fromMessage:(NSDictionary *)dict {
    if ([messageEntity.tag isEqualToString:@"chat"]) {
        NSString *tmpGroup = [dict valueForKeyPath:@"group.id"];
        messageEntity.fromId = tmpGroup;
    } else if ([messageEntity.tag isEqualToString:@"hi"]) {
        messageEntity.fromId = [dict valueForKeyPath:@"from.id"];
    } else if ([messageEntity.tag hasPrefix:@"calendar"]) {
        messageEntity.fromId = [dict valueForKeyPath:@"from.id"];
    }
}

#pragma mark - broadcast
- (void)broadcastMessage:(NSArray *)messageArray {
    // dispatch notification
    if (messageArray.count > 0) {
        for (int i = 0; i < messageArray.count; i++) {
            NoticeMessageEntity *messageEntity = messageArray[i];
            AppMessage *appMessage = [self convertToAppMessage:messageEntity];

            if (!appMessage) {
                continue;
            }

            if ([appMessage.tag isEqualToString:@"chat"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChatContentUpdate object:appMessage];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNoticeMessageContentUpdate object:appMessage];
            }

            if ([appMessage.tag hasPrefix:@"calendar"]) {
                [self handleLocalNotification:appMessage];
            }
        }
    }
}

- (void)handleLocalNotification:(AppMessage *)appMessage {
//    [NoticeTrendViewController addAlertToLocalNotification:appMessage];
}

#pragma mark - Request
- (void)queryMessageLoggerRequest {
    NSString *userId = [AppCacheManager sharedManager].loginUserId;
    if (userId.length > 0) {
        SyncMessageLoggerRequest *request = [[SyncMessageLoggerRequest alloc] init];
        request.uId = [AppCacheManager sharedManager].loginUserId;
        request.lastTimeL = self.lastMessageLoggerDownloadTimeL;
        request.pageSize = @(100);
        request.page = @(self.downloadedMessageLoggerPage);

        WEAKSELF

        _emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
        [_emeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
            if (status == EMEHttpRequestStatusSuccess) {
                weakSelf.syncProgress.labelText =[NSString stringWithFormat:@"同步%d条数据", (1 + weakSelf.downloadedMessageLoggerPage + weakSelf.downloadedCalendarLoggerPage) * [request.pageSize intValue]];
                // write into DB
                [weakSelf processHistoryMessageData:response needBroadcast:YES];
                
                // send request
                if (hasNext) {
                    weakSelf.downloadedMessageLoggerPage++;
                    [weakSelf queryMessageLoggerRequest];
                }
                else {
//                if (weakSelf.firstLoginForTheUser) {
//                    [weakSelf queryCalendarLoggerRequest];
//                }
//                else {
                    weakSelf.syncProgress.labelText =[NSString stringWithFormat:@"已完成数据同步."];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf hideProgressHUD];
                        
                        if (weakSelf.syncDelegate) {
                            [weakSelf.syncDelegate syncHistoryMessageCompleted:weakSelf.syncHistoryMessageForLogin];
                        }
                    });
                    //                }
                }            }
            else {
                [weakSelf hideProgressHUD];
                
                if (weakSelf.syncDelegate) {
                    [weakSelf.syncDelegate syncHistoryMessageFailed:weakSelf.syncHistoryMessageForLogin];
                }
            }
        }];

        [_emeHttpRequest sendRequest:MessageLogger.class loadingTip:NO errorTip:NO];
    }
}

- (void)queryCalendarLoggerRequest {
    self.downloadedDataLoggerType = DownloadLoggerTypeCalendar;

    NSString *userId = [AppCacheManager sharedManager].loginUserId;
    if (userId.length > 0) {
        SyncCalendarLoggerRequest *request = [[SyncCalendarLoggerRequest alloc] init];
        request.uId = [AppCacheManager sharedManager].loginUserId;
        request.lastTimeL = self.lastCalendarLoggerDownloadTimeL;
        request.pageSize = @(100);
        request.page = @(self.downloadedCalendarLoggerPage);

        WEAKSELF

        _emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
        [_emeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
            if (status == EMEHttpRequestStatusSuccess) {
                weakSelf.syncProgress.labelText =[NSString stringWithFormat:@"同步%d条数据", (1 + weakSelf.downloadedMessageLoggerPage + weakSelf.downloadedCalendarLoggerPage) * [request.pageSize intValue]];
                // write into DB
                [weakSelf processHistoryMessageData:response needBroadcast:YES];
                
                // send request
                if (hasNext) {
                    weakSelf.downloadedCalendarLoggerPage++;
                    [weakSelf queryCalendarLoggerRequest];
                }
                else {
                    weakSelf.syncProgress.labelText =[NSString stringWithFormat:@"已完成数据同步."];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf hideProgressHUD];
                        
                        if (weakSelf.syncDelegate) {
                            [weakSelf.syncDelegate syncHistoryMessageCompleted:weakSelf.syncHistoryMessageForLogin];
                        }
                    });
                    
                    [AppCacheManager setLastCalendarLoggerDownloadTimeL:@"done"];
                }
            }
            else {
                [weakSelf hideProgressHUD];
                
                if (weakSelf.syncDelegate) {
                    [weakSelf.syncDelegate syncHistoryMessageFailed:weakSelf.syncHistoryMessageForLogin];
                }
            }
        }];

        [_emeHttpRequest sendRequest:MessageLogger.class loadingTip:NO errorTip:NO];
    }
}

- (void)queryAllUserRequest {
    NSString *userId = [AppCacheManager sharedManager].loginUserId;
    if (userId.length > 0) {
        QueryUserRequest *request = [[QueryUserRequest alloc] init];

        NSString *environmentType = [[EMEConfigManager shareConfigManager] getEnvironmentType];

        _emeHttpAllUserRequest = [[EMEHttpBatchRequest alloc] initWithRequest:request];
        [_emeHttpAllUserRequest setBatchCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
            if (status == EMEHttpRequestStatusSuccess) {
                NSMutableArray *userArray = [[NSMutableArray alloc] init];
                for (Login *user in (NSArray *)response) {
                    AllUserEntity *entity = [[AllUserEntity alloc] init];
                    entity.environmentType = environmentType;
                    entity.uId = user.id;
                    entity.mobile = user.mobile;
                    entity.userString = [user toJSONString];
                    
                    [userArray addObject:entity];
                }
                
                NSString *condition = [NSString stringWithFormat:@"EnvironmentType='%@'", [[EMEConfigManager shareConfigManager] getEnvironmentType]];
                [[[EMEDatabaseManager sharedInstance] allUserEntityDatabase] deleteAll:condition];
                [[[EMEDatabaseManager sharedInstance] allUserEntityDatabase] insertArray:userArray];
            }
            else {
            }
        }];

        [_emeHttpAllUserRequest sendRequest:request response:Login.class loadingTip:NO autoHideLoadingTipAfterCompletion:NO errorTip:NO];
    }
}

#pragma mark - socket listener
- (void)startSocketListener {
}

#pragma mark - fake tip
- (void)createFakeTipData {

    return;

    NoticeMessageEntity *messageEntity = [[NoticeMessageEntity alloc] init];
    messageEntity = [[NoticeMessageEntity alloc] init];
    messageEntity.id = @"system-fake-tip1";
    messageEntity.tag = @"sys_msg";
    messageEntity.uId = [AppCacheManager sharedManager].loginUserId;
    messageEntity.createTime = [[NSDate date] formattedDateWithDefaultFormat];
    messageEntity.message = @"{\"title\": \"欢迎来到商海通\", \"content\": \"和您志同道合的朋友加个好友吧\", \"createTime\": \"2014-01-01 00:00\"}";
    messageEntity.fromId = @"-1";
    [[[EMEDatabaseManager sharedInstance] noticeMessageDatabase] insert:messageEntity];

    //    messageEntity.id = @"system-fake-tip2";
    //    messageEntity.tag = @"sys_msg";
    //    messageEntity.uId = [AppCacheManager sharedManager].loginUserId;
    //    messageEntity.createTime = [[NSDate date] formattedDateWithDefaultFormat];
    //    messageEntity.message = @"{\"title\": \"欢迎来到商海通\", \"content\": \"去朋友的空间看看\", \"createTime\": \"2014-01-01 00:00\"}";
    //    messageEntity.fromId = @"-1";
    //    [[[EMEDatabaseManager sharedInstance] noticeMessageDatabase] insert:messageEntity];

    messageEntity = [[NoticeMessageEntity alloc] init];
    messageEntity.id = @"system-fake-tip3";
    messageEntity.tag = @"sys_msg";
    messageEntity.uId = [AppCacheManager sharedManager].loginUserId;
    messageEntity.createTime = [[NSDate date] formattedDateWithDefaultFormat];
    messageEntity.message = @"{\"title\": \"欢迎来到商海通\", \"content\": \"试试发起一个聊天\", \"createTime\": \"2014-01-01 00:00\"}";
    messageEntity.fromId = @"-1";
    [[[EMEDatabaseManager sharedInstance] noticeMessageDatabase] insert:messageEntity];

    //    messageEntity = [[NoticeMessageEntity alloc] init];
    //    messageEntity.id = @"system-fake-tip4";
    //    messageEntity.tag = @"sys_msg";
    //    messageEntity.uId = [AppCacheManager sharedManager].loginUserId;
    //    messageEntity.createTime = [[NSDate date] formattedDateWithDefaultFormat];
    //    messageEntity.message = @"{\"title\": \"欢迎来到商海通\", \"content\": \"试试创建一个日程安排\", \"createTime\": \"2014-01-01 00:00\"}";
    //    messageEntity.fromId = @"-1";
    //    [[[EMEDatabaseManager sharedInstance] noticeMessageDatabase] insert:messageEntity];

    //群消息
    messageEntity = [[NoticeMessageEntity alloc] init];
    messageEntity.id = @"system-fake-tip5";
    messageEntity.tag = @"chat";
    messageEntity.uId = [AppCacheManager sharedManager].loginUserId;
    messageEntity.createTime = [[NSDate date] formattedDateWithDefaultFormat];
    messageEntity.message = @"{\n    \"id\": \"d3cee9fc-778c-45de-bad3-2a4d2ed8db20\",\n    \"createTimeL\": 1419243675965,\n    \"from\": {\n        \"name\": \"运营官钱美玲\",\n        \"id\": \"7642312e-39d6-4285-b720-4b64d5f9db49\",\n        \"loginName\": \"13917039991\",\n        \"mobile\": \"13917039991\",\n        \"icon\": \"http://115.28.146.78/file/sht/20141127/14/9e2buec2kgi8odt1bbjwq2akiat8vntc.jpg\"\n    },\n    \"id\": \"dac6db22-ff9d-42a7-9db2-8e5a68eeb159\",\n    \"group\": {\n        \"memberLst\": [],\n        \"id\": \"d3cee9fc-778c-45de-bad3-2a4d2ed8db20\",\n        \"memberNum\": 3,\n        \"user\": {\n        },\n        \"group\": true,\n        \"personId\": \"\",\n        \"tag\": \"invite\",\n        \"creatTimeL\": 1418353545873,\n        \"creatTime\": \"2014-12-12 11:05:45\",\n        \"title\": \"迎新群\"\n    },\n    \"content\": {\n        \"type\": \"txt\",\n        \"value\": \"欢迎加入上海通\"\n    },\n    \"createTime\": \"2014-12-22 18:21:15\",\n    \"to\": {\n        \"name\": \"chaihua1🐷🐔😊☺️👻\",\n        \"id\": \"7642312e-39d6-4285-b720-4b64d5f9db49\",\n        \"loginName\": \"13901111111\",\n        \"mobile\": \"13901111111\",\n        \"icon\": \"http://192.168.7.212/file/20141125/10/4sh14b2yo715kdvrxlm8kzxuk941u7um.jpg\"\n    }\n}";
    messageEntity.fromId = @"sys_msg";
    [[[EMEDatabaseManager sharedInstance] noticeMessageDatabase] insert:messageEntity];

    [NetApiChatGroupHelper addMembersQuiesce:@[ [AppCacheManager sharedManager].loginUserId ] withGroupId:@"d3cee9fc-778c-45de-bad3-2a4d2ed8db20" withBlock:nil];
}

@end
