//
//  Login.h
//  EMESHT
//
//  Created by appeme on 14-11-11.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

#pragma mark - Base
@interface Person : LooseJSONModel
@property (nonatomic, copy) NSString *id;       //用户编号
@property (nonatomic, copy) NSString *mobile;   //电话
@property (nonatomic, copy) NSString *sex;      //性别(0:男,1:女)
@property (nonatomic, copy) NSString *name;     //姓名
@property (nonatomic, copy) NSString *weiXing;  //微信号
@property (nonatomic, copy) NSString *province; //省份
@property (nonatomic, copy) NSString *address;  //通讯地址
@property (nonatomic, copy) NSString *email;
@end

@interface Company : LooseJSONModel
@property (nonatomic, copy) NSString *name;     //公司名称
@property (nonatomic, copy) NSArray *industry;  //所属行业
@property (nonatomic, copy) NSString *turnover; //年营业额
@property (nonatomic, copy) NSArray *business;  //主营业务
@end

@interface Job : LooseJSONModel
@property (nonatomic, copy) NSArray *position; //工作职位
@end

@protocol Login
@end

@interface Login : User
@property (nonatomic, copy) NSString *token;     //登录token
@property (nonatomic, copy) NSString *rongToken; //融云token
@end


@interface AllocSocket : LooseJSONModel
@property (nonatomic, copy) NSString *server; //服务IP地址
@property (nonatomic, copy) NSString *port;   //服务器端口
@end

#pragma mark - Request
@interface LoginRequest : LooseJSONModel
@property (nonatomic, copy) NSString *loginName; //用户名
@property (nonatomic, copy) NSString *password;  //密码
@end

@interface WXLoginRequest : LooseJSONModel
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *unionId;
@property (nonatomic, strong) WXUser *uInfo;
@end

@interface LoginOutRequest : LooseJSONModel
@end

@interface RegisterRequest : LooseJSONModel
@property (nonatomic, copy) NSString *mobile;   //手机号
@property (nonatomic, copy) NSString *password; //密码
@property (nonatomic, copy) NSString *name;     //用户姓名
//新api只需要前面的参数
@property (nonatomic, copy) NSString *icon;          //头像
@property (nonatomic, copy) NSString *sign;          //签名
@property (nonatomic, copy) NSString *email;         //邮箱
@property (nonatomic, copy) NSString *company;       //企业名称
@property (nonatomic, copy) NSString *turnover;      //年营业额
@property (nonatomic, copy) NSNumber *turnoverIndex; //年营业额Index [0..n]
@property (nonatomic, copy) NSArray *industry;       //行业
@property (nonatomic, copy) NSArray *business;       //主营业务
@property (nonatomic, copy) NSArray *position;       //职务
@property (nonatomic, copy) NSString *province;      //省份
@property (nonatomic, copy) NSString *address;       //通讯地址
@property (nonatomic, copy) NSArray *city;           //城市
@property (nonatomic, copy) NSString *weiXing;       //微信号
@property (nonatomic, copy) NSString *recommand;     //推荐人
@end

@interface CompleteInfoRequest : RegisterRequest
@property (nonatomic, copy) NSString *id; //用户编号
@end

@interface UpdateInfoRequest : CompleteInfoRequest
@end

@interface UpdatePasswordRequest : RegisterRequest
@property (nonatomic, copy) NSString *loginName;    //用户名
@property (nonatomic, copy) NSString *aNewPassword; //密码
@end

@interface AllocSocketRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId;          //用户编号
@property (nonatomic, copy) NSString *password;     //密码
@property (nonatomic, copy) NSString *aNewPassword; //密码
@end

@interface RefreshRongTokenRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;        //用户编号
@property (nonatomic, copy) NSString *rongToken; //新融云token
@end