//
//  Chat.h
//  EMESHT
//
//  Created by appeme on 14-11-14.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "LooseJSONModel.h"
#import "UserGroup.h"
#import "Content.h"

@interface Subject : LooseJSONModel
@property (nonatomic, copy) NSString *uId;        //用户编号
@property (nonatomic, copy) NSString *toId;       //接收消息的用户编号
@property (nonatomic, copy) NSNumber *gChat;      //是否群组聊天，true:群组聊天
@property (nonatomic, copy) NSString *subject;    //主题
@property (nonatomic, strong) Content *content;   //聊天内容
@property (nonatomic, copy) NSString *updateTime; //时间
@end

@interface Chat : LooseJSONModel
@property (nonatomic, copy) Login *from;           //发送消息用户对象
@property (nonatomic, copy) Login *to;             //接收消息用户对象
@property (nonatomic, copy) NSString *subject;     //聊天主题
@property (nonatomic, copy) NSNumber *gChat;       //是否群组聊天，true:群组聊天
@property (nonatomic, copy) UserGroup *group;      //用户组对象
@property (nonatomic, strong) Content *content;    //聊天内容
@property (nonatomic, copy) NSString *createTime;  //时间
@property (nonatomic, copy) NSNumber *createTimeL; //时间
@end

#pragma mark - Request
@interface QueryChatRequest : LooseJSONModel
@property (nonatomic, copy) NSString *toId;      //接收消息的用户编号
@property (nonatomic, copy) NSNumber *gChat;     //是否群组聊天，true:群组聊天
@property (nonatomic, copy) NSString *fromId;    //发送编号，gChat＝true时为群编号
@property (nonatomic, copy) NSNumber *lastTimeL; //上次接收时间
@end

@interface SendChatRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId;      //添加的用户编号
@property (nonatomic, copy) NSNumber *gChat;    //是否群组聊天，true:群组聊天
@property (nonatomic, copy) NSString *toId;     //聊天目标，如gChat=true聊天组编号，反之聊天用户编号
@property (nonatomic, strong) Content *content; //聊天内容
@end

@interface SayHiRequest : SendChatRequest
@end
