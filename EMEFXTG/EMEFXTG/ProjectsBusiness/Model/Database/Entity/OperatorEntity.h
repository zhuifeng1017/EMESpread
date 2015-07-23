//
//  OperatorEntity.h
//  databaseDemo
//
//  Created by appeme on 14-8-28.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "JSONModel.h"
#import "IDatabaseAttributeQuery.h"

@interface OperatorEntity : JSONModel <IDatabaseAttributeQuery>
//用户编号
@property (retain, nonatomic) NSString *operatorId;
//用户名
@property (retain, nonatomic) NSString *loginName;
//姓名
@property (retain, nonatomic) NSString *name;
//密码
@property (retain, nonatomic) NSString *password;
//手机号码
@property (retain, nonatomic) NSString *mobile;
//注册商铺号
@property (retain, nonatomic) NSString *sCode;
//邮编
@property (retain, nonatomic) NSString *postCode;
//公司
@property (retain, nonatomic) NSString *company;
//邮件
@property (retain, nonatomic) NSString *email;
//qq号
@property (retain, nonatomic) NSString *qq;
//传真
@property (retain, nonatomic) NSString *fax;
//地址
@property (retain, nonatomic) NSString *address;
@end
