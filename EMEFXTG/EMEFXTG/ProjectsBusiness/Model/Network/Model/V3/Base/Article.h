//
//  Article.h
//  EMESHT
//
//  Created by appeme on 14-11-12.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "LooseJSONModel.h"
#import "Login.h"
#import "DescItem.h"
#import "Content.h"

#define kArticleChannelFeel @"feel"
#define kArticleChannelGroup @"group"
#define kArticleChannelNwit @"nwit"

#pragma mark - Base
@interface Article : LooseJSONModel

@property (nonatomic, copy) NSString *id; //编号

@property (nonatomic, strong) Login *author; //文章所属用户对象 [deprecated]

@property (nonatomic, copy) NSString *title; //文章标题

@property (nonatomic, strong) NSMutableArray<DescItem> *descItemLst; //描述列表 [deprecated]

@property (nonatomic, strong) NSArray *imgLst;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) User *creator;

@property (nonatomic, copy) NSString *voice;

@property (nonatomic, copy) NSString *summary; //文章摘要

@property (nonatomic, copy) NSNumber *cCount; //文章评论数

@property (nonatomic, copy) NSNumber *pCount; //文章点赞数

@property (nonatomic, copy) NSNumber *sCount; //文章分享数

@property (nonatomic, copy) NSString *shareUrl; //分享url:微信等使用

@property (nonatomic, copy) NSString *createTime; //创建时间

@property (nonatomic, copy) NSString *channel; // 频道(group:圈子,feel:感悟)

@property (nonatomic, copy) NSString *refId; // 引用预订，比如圈子编号,文章分类编号

@end

#pragma mark - Request
@interface SaveArticleRequest : LooseJSONModel

@property (nonatomic, copy) NSString *gId; //组编号, [deprecated]

@property (nonatomic, copy) NSString *uId; //用户编号

@property (nonatomic, copy) NSString *channel;

@property (nonatomic, copy) NSString *refId;

@property (nonatomic, copy) NSString *title; //文章标题

@property (nonatomic, copy) NSString *content; //内容集合

@property (nonatomic, strong) NSMutableArray<DescItem> *descItemLst; //文章内容 [deprecated]

@property (nonatomic, strong) NSMutableArray *imgLst;

@property (nonatomic, copy) NSString *voice;

@end

@interface QueryArticleRequest : LooseJSONModel
@property (nonatomic, copy) NSString *gId; //圈子编号 [deprecated]

@property (nonatomic, copy) NSString *channel; // 文章标签(group:圈子,feel:感悟)
@property (nonatomic, copy) NSString *refId;
@property (nonatomic, copy) NSString *uId; //用户编号
@property (nonatomic, copy) NSString *title;

@end

@interface PraiseArticleRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;  //文章编号
@property (nonatomic, copy) NSString *uId; //用户编号
@end

@interface GetArticleRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id; //编号
@end

// ----------- unused ---------------
@interface UpdateArticleRequest : SaveArticleRequest
@property (nonatomic, copy) NSString *id; //编号
@end

@interface DeleteArticleRequest : LooseJSONModel
@property (nonatomic, copy) NSArray *idLst; //删除文章编号集合
@property (nonatomic, copy) NSString *uId;  //用户编号 [deprecated]
@end

@interface ShareArticleRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;    //文章编号
@property (nonatomic, copy) NSString *uId;   //用户编号
@property (nonatomic, copy) NSArray *uIdLst; //用户编号
@end

@interface SaveArticleCommentRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;      //文章编号
@property (nonatomic, copy) NSString *uId;     //用户编号
@property (nonatomic, copy) NSString *content; //评论内容
@end

@interface GetArticleCommentRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id; //文章编号
@end

@interface HistoryRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;  //文章编号
@property (nonatomic, copy) NSString *uId; //用户编号
@end

@interface Comment : LooseJSONModel
@property (nonatomic, copy) NSString *id;         //编号
@property (nonatomic, copy) Login *user;          //用户对象,参照/v1/shtapp/base/login返回值
@property (nonatomic, copy) NSString *content;    //评论内容
@property (nonatomic, copy) NSString *createTime; //创建时间
@end
