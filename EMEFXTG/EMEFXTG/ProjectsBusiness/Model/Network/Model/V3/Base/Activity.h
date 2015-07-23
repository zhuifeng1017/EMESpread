//
//  Activity.h
//  EMEZL
//
//  Created by apple on 15/4/22.
//  Copyright (c) 2015年 appeme. All rights reserved.
//

#import "LooseJSONModel.h"
#import "Article.h"

#define kActivityChannel @"activity"

@interface BaseActivity : LooseJSONModel
@property (nonatomic, copy) NSString *title;    //活动标题
@property (nonatomic, copy) NSString *phone;    //联系电话
@property (nonatomic, copy) NSString *time;     //活动时间,格式为yyy-MM-dd HH:mm:ss
@property (nonatomic, copy) NSString *address;  //活动地点
@property (nonatomic, strong) NSArray *imgLst;  //活动内容图片集合
@property (nonatomic, copy) NSString *content;  //活动内容
@property (nonatomic, copy) NSString *remark;   //备注
@property (nonatomic, copy) NSNumber *total;    //报名人数
@property (nonatomic, copy) NSNumber *money;    //费用
@property (nonatomic, copy) NSString *shareUrl; //分享url:微信等使用
@end

@interface Activity : BaseActivity
@property (nonatomic, copy) NSString *id;         //编号
@property (nonatomic, copy) NSNumber *remain;     // 剩余报名人数
@property (nonatomic, strong) Login *creator;     // 创建用户
@property (nonatomic, copy) NSNumber *cCount;     // 评论数
@property (nonatomic, copy) NSNumber *pCount;     // 点赞数
@property (nonatomic, copy) NSNumber *sCount;     // 分享数
@property (nonatomic, copy) NSString *createTime; // 创建时间
@end

@protocol ActivityProject <NSObject>
@end

@interface ActivityProject : LooseJSONModel
@property (nonatomic, copy) NSString *id;    //项目编号
@property (nonatomic, copy) NSString *title; //项目名称
@end

@interface ApplyActivityResponse : LooseJSONModel
@property (nonatomic, copy) NSString *id;               //编号
@property (nonatomic, strong) ActivityProject *project; // 报名项目
@property (nonatomic, strong) Login *user;              // 报名用户
@property (nonatomic, copy) NSString *createTime;       // 创建时间
@end

#pragma mark - Request
@interface SaveActivityRequest : BaseActivity
@property (nonatomic, copy) NSString *uId; //创建用户编号
@end

@interface UpdateActivityRequest : BaseActivity
@property (nonatomic, copy) NSString *id; //编号
@end

@interface QueryActivityRequest : LooseJSONModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *uId; //用户编号
@end

@interface QueryMyActivityRequest : QueryActivityRequest
@end

@interface QueryMyFavActivityRequest : QueryActivityRequest
@end

@interface SaveActivityCommentRequest : SaveArticleCommentRequest
@end

@interface QueryActivityCommentRequest : LooseJSONModel
@end

@interface PraiseActivityRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;  //编号
@property (nonatomic, copy) NSString *uId; //用户编号
@end

@interface ActivityApplyRequest : PraiseActivityRequest
@end

@interface QueryActivityApplyRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id; //编号
@end

@interface StarActivityRequest : PraiseActivityRequest
@end

@interface UnStarActivityRequest : LooseJSONModel
@property (nonatomic, copy) NSArray *idLst;
@property (nonatomic, copy) NSString *uId; //用户编号
@end

@interface UnStarActivityResponse : UnStarActivityRequest
@end

@interface GetActivityRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id; //编号
@end
