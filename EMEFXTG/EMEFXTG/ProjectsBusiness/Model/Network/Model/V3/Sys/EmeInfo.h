//
//  EmeInfo.h
//  EMEHS-MGT
//
//  Created by appeme on 14-9-4.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

@interface EmeInfo : LooseJSONModel

@property (nonatomic, copy) NSString *id;      //伊墨企业信息信息对象id
@property (nonatomic, copy) NSString *name;    //企业名称
@property (nonatomic, copy) NSString *address; //企业地址
@property (nonatomic, copy) NSString *phone;   //企业电话
@property (nonatomic, copy) NSString *email;   //企业邮箱
@property (nonatomic, copy) NSString *fax;     //企业传真
@property (nonatomic, copy) NSString *site;    //企业官网
@property (nonatomic, copy) NSString *desc;    //企业描述
@property (nonatomic, copy) NSString *city;    //企业城市
@end

@interface SaveEmeInfoRequest : EmeInfo

@end

@interface GetEmeInfoRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;   //主键
@property (nonatomic, copy) EmeInfo *value; //伊墨企业信息对象
@end