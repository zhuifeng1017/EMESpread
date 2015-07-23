//
//  SubMessage.h
//  EMESHT
//
//  Created by appeme on 14-11-14.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "LooseJSONModel.h"
#import "Chat.h"
#import "UserGroup.h"

#pragma mark - Base

#pragma mark - 消息类型——请求加好友,同意加好友,拒绝加好友
@interface SubMessageFriendActionContent : LooseJSONModel
@property (nonatomic, copy) User *user;           //用户编号
@property (nonatomic, copy) User *friend;         //添加好友的用户编号
@property (nonatomic, copy) NSString *desc;       //描述信息，例如'wanjj 拒绝加你为好友'
@property (nonatomic, copy) NSString *createTime; //时间
@end

#pragma mark - 消息类型——聊天
@interface SubMessageChatContent : LooseJSONModel
@property (nonatomic, copy) NSString *id; //消息编号
@property (nonatomic, strong) Login *from;
@property (nonatomic, strong) Login *to;
@property (nonatomic, copy) UserGroup *group;
@property (nonatomic, strong) Content *content; //聊天内容
@end

#pragma mark - 消息类型——打招呼
@interface SubHiSendContent : LooseJSONModel
@property (nonatomic, copy) NSString *id; //消息编号
@property (nonatomic, strong) Login *from;
@property (nonatomic, strong) Login *to;
@property (nonatomic, strong) Content *content;   //聊天内容
@property (nonatomic, copy) NSString *createTime; //时间
@end

@interface SubMessageCalendarContent : SubMessageChatContent
@property (nonatomic, copy) NSString *id;                //编号
@property (nonatomic, strong) Login *owner;              //日程所有用户（创建用户）对象
@property (nonatomic, copy) NSString *address;           //邀约地址
@property (nonatomic, copy) NSString *fromTime;          //开始时间
@property (nonatomic, copy) NSString *toTime;            //结束日期
@property (nonatomic, strong) NSArray<Login> *memberLst; //邀约成员
@property (nonatomic, copy) NSString *chatGroupId;       //聊天组编号
@property (nonatomic, copy) NSString *createTime;        //创建时间
@property (nonatomic, copy) NSArray *alert;              //提醒时间
@end

@interface SubMessageSystemContent : LooseJSONModel
@property (nonatomic, copy) NSString *id;         //编号
@property (nonatomic, copy) NSString *title;      //聊天内容
@property (nonatomic, copy) NSString *content;    //聊天内容
@property (nonatomic, copy) NSString *createTime; //时间
@end

@interface SubMessageShareArticleContent : LooseJSONModel
@property (nonatomic, copy) NSString *id; //文章编号
@end

#pragma mark - Request