//
//  Resource.h
//  EMESHT
//
//  Created by xuanhr on 15/2/2.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Resource : LooseJSONModel
@property (nonatomic, copy) NSString *id;           //编号
@property (nonatomic, copy) NSString *uId;          //用户编号
@property (nonatomic, copy) NSArray *tagLst;        //资源类型，0:项目,1:资金,2:渠道
@property (nonatomic, copy) NSString *content;      //资源内容
@property (nonatomic, copy) NSString *title;        //资源标题标题
@property (nonatomic, copy) NSMutableArray *imgLst; //图片列表
@property (nonatomic, copy) NSString *createTime;   //创建时间
@property (nonatomic, copy) NSString *updateTime;   //修改时间
@property (nonatomic, copy) User *user;             //用户对象
@property (nonatomic, copy) NSString *requirement;  //供需标示，"0"：需求，"1":供求
@property (nonatomic, copy) NSNumber *pCount;       //点赞数

@end

@interface Priase : LooseJSONModel
@property (nonatomic, copy) NSString *id;       //编号
@property (nonatomic, copy) NSString *source;   //点赞类型
@property (nonatomic, copy) NSString *sourceId; //点赞编号
@property (nonatomic, copy) NSNumber *count;    //点赞数
@property (nonatomic, copy) NSArray *praiseLst; //点赞明细
@end

@interface PriaseDetail : LooseJSONModel
@property (nonatomic, copy) User *user;          //用户
@property (nonatomic, copy) NSArray *createTime; //点赞时间
@end

@protocol CommentDetail <NSObject>
@end

@interface CommentDetail : LooseJSONModel
@property (nonatomic, copy) NSString *id;                     //编号
@property (nonatomic, copy) User *user;                       //评论用户
@property (nonatomic, copy) NSString *content;                //评论内容
@property (nonatomic, copy) NSArray<CommentDetail> *replyLst; //评论明细
@property (nonatomic, copy) NSString *createTime;             //创建时间
@property (nonatomic, assign) BOOL isReply;                   //评论：0，回复：1
@end

@interface SaveResourceRequest : LooseJSONModel

@property (nonatomic, copy) NSString *uId;         //用户编号
@property (nonatomic, copy) NSArray *tagLst;       //资源类型，0:项目,1:资金,2:渠道
@property (nonatomic, copy) NSString *content;     //资源内容
@property (nonatomic, copy) NSString *title;       //资源标题标题
@property (nonatomic, copy) NSArray *imgLst;       //图片列表
@property (nonatomic, copy) NSString *requirement; //供需标示，"0"：需求，"1":供求
@property (nonatomic, copy) User *user;            //用户
@end

@interface UpdateResourceRequest : SaveResourceRequest
@property (nonatomic, copy) NSString *id;          //用户编号
@property (nonatomic, copy) NSString *requirement; //供需标示，"0"：需求，"1":供求
@end

@interface QueryResourceRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId;         //用户编号
@property (nonatomic, copy) NSString *title;       //资源标题标题
@property (nonatomic, copy) NSString *requirement; //供需标示，"0"：需求，"1":供求
@property (nonatomic, copy) NSString *tag;         //资源类型,"-1":所有资源,"0":项目,"1":资金,"2":渠道
@end

@interface DeleteResourceRequest : LooseJSONModel
@property (nonatomic, copy) NSArray *idLst;
@end

@interface ResourcePraiseRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *uId;
@end

@interface QueryPraiseRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@end

@interface ResourceCommentRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *uId;
@property (nonatomic, copy) NSString *content;
@end

@interface CommentReplyRequest : ResourceCommentRequest
@end

@interface QueryCommentRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@end
