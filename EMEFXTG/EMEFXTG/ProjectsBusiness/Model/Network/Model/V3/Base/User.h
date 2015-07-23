//
//  User.h
//  EMESHT
//
//  Created by appeme on 14-11-13.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "LooseJSONModel.h"
@class Job;
@class Company;

#pragma mark - Base
@protocol User
@end

@interface User : LooseJSONModel
@property (nonatomic, copy) NSString *id;         //用户编号
@property (nonatomic, copy) NSString *loginName;  //用户名
@property (nonatomic, copy) NSString *mobile;     //手机号
@property (nonatomic, copy) NSString *name;       //用户姓名
@property (nonatomic, copy) NSString *sex;        //性别(0:男,1:女)
@property (nonatomic, copy) NSString *icon;       //用户图像
@property (nonatomic, strong) Company *company;   //公司
@property (nonatomic, strong) Job *job;           //工作
@property (nonatomic, copy) NSString *province;   //省份
@property (nonatomic, copy) NSString *address;    //通讯地址
@property (nonatomic, copy) NSString *weiXing;    //微信号
@property (nonatomic, copy) NSString *recommand;  //推荐人
@property (nonatomic, copy) NSArray *city;        //城市
@property (nonatomic, copy) NSString *status;     //用户状态,(-1:未审核,0:正常,1:关闭)
@property (nonatomic, copy) NSString *tag;        //用户类型标示(user:普通用户,service:客服)
@property (nonatomic, copy) NSString *createTime; //创建时间
@property (nonatomic, copy) NSString *sign;       //签名
@property (nonatomic, copy) NSString *email;
@end

@interface WXUser : LooseJSONModel
@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *headimgurl;
@end

@interface WXLogin : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *unionId;
@property (nonatomic, copy) NSString *loginName;
@property (nonatomic, strong) WXUser *uInfo;
@property (nonatomic, copy) NSString *fromSNS;
@property (nonatomic, copy) NSString *createTime;
@end

#pragma mark - Request

@interface QueryUserRequest : LooseJSONModel
@property (nonatomic, copy) NSString *param;   //查询
@property (nonatomic, copy) NSNumber *service; //是否客户员（true:是客服,false:普通用户,缺省所有用户）
@end

@interface QueryMobileRequest : LooseJSONModel
@property (nonatomic, copy) NSArray *mobileLst; //用户手机号列表
@end

@interface WeixinCompleteRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *password;
@end
