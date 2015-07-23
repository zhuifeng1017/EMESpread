//
//  SocialGroup.h
//  EMESHT
//
//  Created by appeme on 15/3/5.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DescItem.h"
#import "Chat.h"
#import "Notice.h"

#pragma mark - Base
@interface SocialGroup : LooseJSONModel
@property (nonatomic, copy) NSString *id;          //编号
@property (nonatomic, copy) NSString *title;       //圈子标题
@property (nonatomic, copy) NSString *content;     //圈子描述
@property (nonatomic, copy) NSString *intro;       //介绍
@property (nonatomic, copy) NSString *priority;    //推荐值
@property (nonatomic, copy) NSString *active;      //活跃度
@property (nonatomic, copy) User *creator;         //创建用户对象
@property (nonatomic, copy) NSString *chatGroupId; //聊天组编号
@property (nonatomic, copy) NSString *createTime;  //创建时间
@property (nonatomic, copy) NSString *updateTime;  //修改时间
@end

@interface GetSocialGroupInviteResponse : LooseJSONModel
@property (nonatomic, strong) User *from;         //邀请人
@property (nonatomic, strong) SocialGroup *group; //
@end

@interface SocialGroupMember : LooseJSONModel
@property (nonatomic, copy) NSString *id;         //圈子编号
@property (nonatomic, copy) User *user;           //圈子成员
@property (nonatomic, copy) NSNumber *admin;      //是否为管理员
@property (nonatomic, copy) NSString *createTime; //创建时间
@end

#pragma mark - Request
@interface SaveSocialGroupRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId;     //用户编号
@property (nonatomic, copy) NSString *title;   //圈子标题
@property (nonatomic, copy) NSString *content; //圈子描述
@end

@interface UpdateSocialGroupRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;    //编号
@property (nonatomic, copy) NSString *title; //圈子标题
@end

@interface QuerySocialGroupRequest : LooseJSONModel
@property (nonatomic, copy) NSString *title; //圈子标题
@end

@interface ApplySocialGroupRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;  //圈子编号
@property (nonatomic, copy) NSString *uId; //用户编号
@end

@interface InviteSocialGroupRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;    //圈子编号
@property (nonatomic, copy) NSString *fId;   //邀请用户编号
@property (nonatomic, copy) NSArray *uIdLst; //邀请用户编号集合
@end

@interface PassApplySocialGroupRequest : ApplySocialGroupRequest
@end

@interface PassInviteSocialGroupRequest : ApplySocialGroupRequest
@end

@interface RefuseApplySocialGroupRequest : ApplySocialGroupRequest
@end

@interface RefuseInviteSocialGroupRequest : ApplySocialGroupRequest
@end

@interface AdminSocialGroupRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;    //圈子编号
@property (nonatomic, copy) NSArray *uIdLst; //设置管理员的用户编号集合
@end

@interface GetApplySocialGroupRequest : ApplySocialGroupRequest
@end

@interface GetInviteSocialGroupRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId; //用户编号
@end

@interface GetMemberSocialGroupRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id; //圈子编号
@end

@interface MySocialGroupRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId; //用户编号
@end

@interface ExitSocialGroupRequest : ApplySocialGroupRequest
@end

@interface DeleteMemberSocialGroupRequest : AdminSocialGroupRequest
@end

#pragma mark - 圈子公告
#pragma mark - Base
@interface SocialGroupAnnounce : LooseJSONModel
@property (nonatomic, copy) NSString *id; //编号
@property (nonatomic, copy) User *author;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray<DescItem> *descItemLst; //公告内容
@property (nonatomic, copy) NSString *summery;
@property (nonatomic, copy) NSString *createTime;
@end

#pragma mark - Request
@interface SaveSocialGroupAnnounceRequest : LooseJSONModel
@property (nonatomic, copy) NSString *gId; //圈子编号
@property (nonatomic, copy) NSString *uId; //用户编号
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray<DescItem> *descItemLst; //公告内容
@end

@interface UpdateSocialGroupAnnounceRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id; //圈子编号
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray<DescItem> *descItemLst; //公告内容
@end

@interface QuerySocialGroupAnnounceRequest : LooseJSONModel
@property (nonatomic, copy) NSString *gId; //圈子编号
@end

@interface DeleteSocialGroupAnnounceRequest : LooseJSONModel
@property (nonatomic, copy) NSArray *idLst; //公告内容
@end

#pragma mark - 圈子发言
#pragma mark - Base
@interface Speak : LooseJSONModel
@property (nonatomic, copy) NSString *id;                          //编号
@property (nonatomic, copy) NSString *title;                       //圈子标题
@property (nonatomic, strong) NSMutableArray<Content> *contentLst; //内容集合
@property (nonatomic, strong) User *author;                        //作者
@property (nonatomic, copy) NSNumber *cCount;                      //评论数
@property (nonatomic, copy) NSNumber *pCount;                      //点赞数
@property (nonatomic, copy) NSNumber *sCount;                      //分享数
@property (nonatomic, copy) NSString *createTime;                  //创建时间
@end

#pragma mark - Request
@interface SaveSpeakRequest : LooseJSONModel
@property (nonatomic, copy) NSString *gId;                         //圈子编号
@property (nonatomic, copy) NSString *uId;                         //用户编号
@property (nonatomic, copy) NSString *title;                       //公告标题
@property (nonatomic, strong) NSMutableArray<Content> *contentLst; //内容集合
@end

@interface UpdateSpeakRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;                          //编号
@property (nonatomic, copy) NSString *title;                       //公告标题
@property (nonatomic, strong) NSMutableArray<Content> *contentLst; //内容集合
@end

@interface QuerySpeakRequest : LooseJSONModel
@property (nonatomic, copy) NSString *gId; //圈子编号
@end

@interface deleteSpeakRequest : LooseJSONModel
@property (nonatomic, strong) NSMutableArray *idLst; //删除编号集合
@end

#pragma mark - 圈子公告
@interface SaveSocialGroupNoticeRequest : Notice
@property (nonatomic, copy) NSString *gId; //圈子编号
@property (nonatomic, copy) NSString *uId; //用户编号
@end

@interface SaveSocialGroupNoticeResponse : SaveSocialGroupNoticeRequest
@end