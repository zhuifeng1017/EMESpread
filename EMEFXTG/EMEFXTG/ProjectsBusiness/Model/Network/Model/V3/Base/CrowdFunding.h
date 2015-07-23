//
//  CrowdFunding.h
//  EMESHT
//
//  Created by xuanhr on 15/1/22.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "LooseJSONModel.h"

@interface CrowdFunding : LooseJSONModel
@property (nonatomic, copy) NSString *id;         //编号
@property (nonatomic, copy) NSString *uId;        //用户编号
@property (nonatomic, copy) NSArray *tagLst;      //众筹类型，0:项目,1:资金,2:渠道
@property (nonatomic, copy) NSString *content;    //众筹内容
@property (nonatomic, copy) NSString *title;      //标题
@property (nonatomic, copy) NSString *imgLst;     //图片列表
@property (nonatomic, copy) NSString *createTime; //创建时间
@property (nonatomic, copy) NSString *updateTime; //修改时间

@end

@interface SaveCrowdFundingRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId;     //用户编号
@property (nonatomic, copy) NSArray *tagLst;   //众筹类型，0:项目,1:资金,2:渠道
@property (nonatomic, copy) NSString *content; //众筹内容
@property (nonatomic, copy) NSString *title;   //标题
@property (nonatomic, copy) NSString *imgLst;  //图片列表
@end

@interface UpdateCrowdFundingRequest : SaveCrowdFundingRequest
@property (nonatomic, copy) NSString *id; //编号
@end

@interface QueryCrowdFundingRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId;     //用户编号
@property (nonatomic, copy) NSString *content; //众筹内容
@end

@interface DeleteCrowdFundingRequest : LooseJSONModel
@property (nonatomic, copy) NSArray *idLst; //编号集合
@end