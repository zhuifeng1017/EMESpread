//
//  FudScheme.h
//  EMESHT
//
//  Created by appeme on 15/3/18.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "LooseJSONModel.h"
#import "DescItem.h"
#import "Login.h"

@protocol FudSchemeResource <NSObject>
@end

@protocol FudSchemeResourceDescItem <NSObject>
@end

@interface FudScheme : LooseJSONModel
@property (nonatomic, copy) NSString *id;      //编号
@property (nonatomic, copy) NSString *title;   //招募众筹标题
@property (nonatomic, copy) NSString *content; //招募众筹描述
@property (nonatomic, strong)
    NSMutableArray<DescItem> *descItemLst; //招募众筹描述集合
@property (nonatomic, strong)
    NSMutableArray<FudSchemeResource> *resourceLst; //众筹资源集合
@property (nonatomic, strong)
    NSString *status;                               // NEW:新建状态,SUCCESS:招募成功,CLOSED:关闭状态
@property (nonatomic, strong) NSNumber *pCount;     //点赞数
@property (nonatomic, strong) NSString *shareUrl;   //点赞数
@property (nonatomic, strong) NSString *tag;        //项目标签,project:认购中,scheme:招募中
@property (nonatomic, strong) Login *creator;       // Login
@property (nonatomic, strong) NSString *createTime; //创建时间
@end

@interface FudSchemeResourceDescItem : DescItem
@property (nonatomic, strong)
    Login *provider;                                //提供者(用户对象),参照/v1/shtapp/base/login返回值
@property (nonatomic, strong) NSString *createTime; //创建时间
@end

@interface FudSchemeResource : LooseJSONModel
@property (nonatomic, copy) NSString *id;      //资源编号
@property (nonatomic, copy) NSString *title;   //资源标题
@property (nonatomic, copy) NSString *content; //资源描述
@property (nonatomic, strong)
    NSMutableArray<FudSchemeResourceDescItem> *descItemLst; //资源描述集合
@property (nonatomic, strong)
    Login *provider;                                //提供者(用户对象),参照/v1/shtapp/base/login返回值
@property (nonatomic, strong) NSString *createTime; //创建时间
@end

@interface FudProject : FudScheme
@property (nonatomic, copy) NSNumber *money; //购买每份众筹价格
@property (nonatomic, copy) NSNumber *count; //众筹份数
@property (nonatomic, copy) NSNumber *limit; //限购份数
@property (nonatomic, copy) NSNumber *sale;  //销售份数
@end

@interface FudProjectBuyInfo : LooseJSONModel
@property (nonatomic, copy) NSString *id;          //编号
@property (nonatomic, strong) FudProject *project; //众筹项目
@property (nonatomic, strong)
    Login *buyer;                            //购买用户(用户对象),参照/v1/shtapp/base/login返回值
@property (nonatomic, copy) NSNumber *count; //购买份数
@property (nonatomic, copy) NSNumber *total; //支付金额
@property (nonatomic, copy)
    NSString *status;                             // NEW:新建状态, PAY:已经支付, CANCAL:取消支付
@property (nonatomic, copy) NSString *remark;     //备注
@property (nonatomic, copy) NSString *createTime; //创建时间@end
@end

#pragma mark - Request
@interface SaveFudSchemeRequest : LooseJSONModel
@property (nonatomic, copy) NSString *title;                  //招募众筹标题
@property (nonatomic, copy) NSString *content;                //资源描述
@property (nonatomic, copy) NSString *uId;                    //创建招募众筹用户编号
@property (nonatomic, strong) NSArray<DescItem> *descItemLst; //招募众筹描述集合
@property (nonatomic, strong)
    NSArray<FudSchemeResource> *resourceLst; //众筹资源集合
@end

@interface UpdateFudSchemeRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;                     //编号
@property (nonatomic, copy) NSString *title;                  //招募众筹标题
@property (nonatomic, copy) NSString *content;                //资源描述
@property (nonatomic, strong) NSArray<DescItem> *descItemLst; //招募众筹描述集合
@property (nonatomic, strong)
    NSArray<FudSchemeResource> *resourceLst; //众筹资源集合
@end

@interface QueryFudSchemeRequest : LooseJSONModel
@property (nonatomic, copy) NSString *title; //招募众筹标题
@property (nonatomic, copy) NSString *uId;   //创建招募众筹用户编号
@end

@interface DeleteFudSchemeRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id; //编号
@property (nonatomic, copy) NSString *uId; //用户编号
@end

@interface PraiseFudSchemeRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;  //众筹项目编号
@property (nonatomic, copy) NSString *uId; //用户编号
@end

@interface SaveFudSchemeResourceRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;                   //招募众筹编号
@property (nonatomic, copy) NSString *title;                //招募众筹资源标题
@property (nonatomic, copy) NSString *content;              //资源描述
@property (nonatomic, copy) NSString *uId;                  //创建招募众筹资源用户编号
@property (nonatomic, copy) NSArray<DescItem> *descItemLst; //招募众筹描述集合
@end

@interface UpdateFudSchemeResourceRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;          //招募众筹编号
@property (nonatomic, copy) NSString *title;       //招募众筹资源标题
@property (nonatomic, copy) NSString *content;     //资源描述
@property (nonatomic, copy) NSString *rId;         //招募众筹资源编号
@property (nonatomic, copy) NSString *descItemLst; //招募众筹描述集合
@end

@interface DeleteFudSchemeResourceRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;  //招募众筹编号
@property (nonatomic, copy) NSString *rId; //招募众筹资源编号
@end

#pragma mark - FudProject Request
@interface QueryFudProjectRequest : LooseJSONModel
@property (nonatomic, copy) NSString *title; //招募众筹标题
@end

@interface PraiseFudProjectRequest : PraiseFudSchemeRequest
@end

@interface PayFudProjectRequest : PraiseFudProjectRequest
@property (nonatomic, copy) NSNumber *count; //购买份数
@end

@interface QueryPayFudProjectRequest : LooseJSONModel
@property (nonatomic, copy) NSString *pId; //众筹项目编号
@end

@interface MyFudSchemeRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId; //用户编号
@end

@interface MyFudProjectRequest : MyFudSchemeRequest
@end
