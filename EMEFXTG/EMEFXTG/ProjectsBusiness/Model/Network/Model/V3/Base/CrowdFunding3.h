//
//  CrowdFunding3.h
//  EMESHT
//
//  Created by apple on 15/5/7.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "LooseJSONModel.h"

//NEW:新建状态, SUBMIT:提交审核, NOTPASS:审核未通过, PASS:审核通过, RELEASE:发布状态, FUDCLOSED:招募结束
#define CrowdFunding3StatusNew @"NEW"
#define CrowdFunding3StatusSubmit @"SUBMIT"
#define CrowdFunding3StatusNotPass @"NOTPASS"
#define CrowdFunding3StatusPass @"PASS"
#define CrowdFunding3StatusRelease @"RELEASE"
#define CrowdFunding3StatusFudClosed @"FUDCLOSED"

@protocol CrowdFunding3Genre
@end

@protocol CrowdFunding3Project
@end

@protocol CrowdFunding3Invest
@end

@interface CrowdFunding3Genre : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@end

@interface CrowdFunding3Project : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSNumber *money;
@end

@interface CrowdFunding3Invest : LooseJSONModel
@property (nonatomic, copy) NSString *id;           // 众筹收益编号
@property (nonatomic, copy) NSNumber *price;        // 金额
@property (nonatomic, copy) NSNumber *limit;        // 限购份数
@property (nonatomic, copy) NSNumber *count;        // 总份数
@property (nonatomic, copy) NSString *income;       // 收益描述
@property (nonatomic, copy) NSString *delivery;     // 运费描述
@property (nonatomic, copy) NSNumber *feedbackTime; // 回报时间描述
@end

@interface BaseCrowdFunding3 : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *content;              // 众筹内容
@property (nonatomic, copy) NSNumber *day;                  // 众筹天数
@property (nonatomic, copy) NSNumber *financing;            // 筹资金额
@property (nonatomic, copy) NSString *ask;                  // 问答
@property (nonatomic, strong) CrowdFunding3Genre *genre;    // 众筹资类型
@property (nonatomic, strong) CrowdFunding3Genre *category; // 众筹资分类
@end

@interface CrowdFunding3 : BaseCrowdFunding3
@property (nonatomic, copy) NSNumber *remainDay;        // 剩余众筹天数
@property (nonatomic, copy) NSNumber *receiveFinancing; // 接受筹资金额
@property (nonatomic, copy) NSNumber *cCount;           // 评论数
@property (nonatomic, copy) NSNumber *pCount;           // 点赞数
@property (nonatomic, copy) NSNumber *hCount;           // 关注数
@property (nonatomic, copy) NSNumber *support;          // 支持数
@property (nonatomic, strong) NSArray<CrowdFunding3Invest> *investLst;
@property (nonatomic, copy) NSString *shareUrl; //分享地址
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) User *creator;
@property (nonatomic, copy) NSString *createTime;  // 创建时间
@property (nonatomic, copy) NSString *releaseTime; // 创建时间
@property (nonatomic, copy) NSString *closedTime;  // 结束时间

@end

#pragma mark - response object
@interface CrowdFunding3Response : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, strong) CrowdFunding3Project *project;
@property (nonatomic, strong) User *buyer;
@property (nonatomic, copy) NSNumber *count; // 购买份数
@property (nonatomic, copy) NSNumber *total; // 支付金额
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *createTime;
@end

#pragma mark - request

@interface QueryCrowdFunding3GenreRequest : LooseJSONModel

@end

@interface QueryCrowdFunding3CategoryRequest : LooseJSONModel

@end

@interface QueryCrowdFunding3Request : LooseJSONModel
@property (nonatomic, copy) NSNumber *recommand; // true:推荐,false:不推荐
@property (nonatomic, copy) NSString *title;     // 众筹标题
@property (nonatomic, copy) NSString *gId;       // 招募类型
@property (nonatomic, copy) NSString *cId;       // 招募分类
@end

// 创建众筹申请
@interface SaveCrowdFunding3Request : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSNumber *day;     // 众筹天数
@property (nonatomic, copy) NSNumber *money;   // 众筹资金
@property (nonatomic, copy) NSString *contact; // 联系人
@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *uId; //创建众筹用户编号
@property (nonatomic, copy) NSString *gId; // 众筹类型编号
@property (nonatomic, copy) NSString *cId; // 众筹分类编号

@end

@interface UpdateCrowdFunding3Request : SaveCrowdFunding3Request
@end

// 删除众筹申请
@interface DelCrowdFunding3Request : LooseJSONModel
@property (nonatomic, strong) NSArray *idLst;
@end

@interface DelCrowdFunding3Response : DelCrowdFunding3Request
@end

// 提交众筹申请
@interface AuditCrowdFunding3Request : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@end

@interface PayCrowdFunding3Request : LooseJSONModel
@property (nonatomic, copy) NSString *id;    // 众筹收益编号
@property (nonatomic, copy) NSString *uId;   // 用户编号
@property (nonatomic, copy) NSNumber *count; //购买份数
@property (nonatomic, copy) NSString *remark;
@end

@interface AskCrowdFunding3Request : LooseJSONModel
@end

@interface AskCrowdFunding3Response : LooseJSONModel
@property (nonatomic, copy) NSString *content;
@end

@interface PraiseCrowdFunding3Request : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *uId;
@end

@interface StarCrowdFunding3Request : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *uId;
@end

// 得到众筹
@interface GetCrowdFunding3Request : LooseJSONModel
@property (nonatomic, copy) NSString *id; // 众筹项目编号
@end

#pragma mark - 我申请的/我购买的/我关注的
@interface MyFudApplyRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId;
@end

@interface MyFudApplyResponse : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSNumber *day;     // 众筹天数
@property (nonatomic, copy) NSNumber *money;   // 众筹资金
@property (nonatomic, copy) NSString *contact; // 联系人
@property (nonatomic, copy) NSString *phone;

@property (nonatomic, strong) CrowdFunding3Genre *genre;    // 众筹资类型
@property (nonatomic, strong) CrowdFunding3Genre *category; // 众筹资分类

@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) User *creator;
@property (nonatomic, copy) NSString *createTime;
@end

@interface MyPayCrowdFunding3Request : MyFudApplyRequest
@end

@interface MyStaredCrowdFunding3Request : MyFudApplyRequest
@end

#pragma mark - 认购情况
@interface QueryPayCrowdFunding3Request : LooseJSONModel
@property (nonatomic, copy) NSString *pId;
@end

#pragma mark - Comment
@interface SaveCrowdFunding3CommentRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;      //文章编号
@property (nonatomic, copy) NSString *uId;     //用户编号
@property (nonatomic, copy) NSString *content; //评论内容
@end
