//
//  RongChatEntity.h
//  EMEZL
//
//  Created by appeme on 15-4-18.
//  Copyright (c) 2015年 appeme. All rights reserved.
//

#import "JSONModel.h"
#import "IDatabaseAttributeQuery.h"

@interface RongChatEntity : JSONModel <IDatabaseAttributeQuery>
//conversationType: private,discussion,group,chatroom,customerservice,system
@property (nonatomic, strong) NSString *conversationType;
//目标ID，如讨论组ID, 群ID, 聊天室ID
@property (nonatomic, strong) NSString *targetId;
@property (nonatomic, strong) NSString *messageId;
//消息方向 send = 1,receive = 2
@property (nonatomic, strong) NSString *messageDirection;
@property (nonatomic, strong) NSString *senderUserId;
//接受状态 未读:unread = 0, 已读:read = 1, 未读:listened = 2, 已下载:downloaded = 4
@property (nonatomic, strong) NSString *receivedStatus;
//发送状态 发送中:sending = 10, 发送失败:failed = 20, 已发送:sent = 30, 对方已接收:received = 40, 对方已读:read = 50, 对方已销毁:destroyed = 60
@property (nonatomic, strong) NSString *sentStatus;
@property (nonatomic, strong) NSString *receivedTime;
@property (nonatomic, strong) NSString *sentTime;
//消息体名称
@property (nonatomic, strong) NSString *objectName;
// 消息内容 RCMessageContent
//@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *extra;

//contentType: image, location, richcontent, notification, status, text, voice
//@property (nonatomic, strong) NSString *contentType;//same as objectName, useless
@property (nonatomic, strong) NSString *contentOfContent;
@property (nonatomic, strong) NSString *contentPushContent;
@property (nonatomic, strong) NSString *contentUrl;
@property (nonatomic, strong) NSString *contentDuration;
@property (nonatomic, strong) NSString *contentExtra;
@end
