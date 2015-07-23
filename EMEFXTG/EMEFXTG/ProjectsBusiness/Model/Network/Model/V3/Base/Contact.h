//
//  Contact.h
//  EMESHT
//
//  Created by appeme on 14-11-11.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Login.h"

#pragma mark - Base
@protocol Contact
@end

@interface Contact : LooseJSONModel
@property (nonatomic, copy) NSString *id;          //用户编号
@property (nonatomic, copy) NSString *name;        //姓名
@property (nonatomic, copy) NSString *mobile;      //电话
@property (nonatomic, copy) NSString *sex;         //性别(0:男,1:女)
@property (nonatomic, copy) NSString *icon;        //用户图像
@property (nonatomic, copy) NSString *industry;    //行业
@property (nonatomic, assign) NSNumber *edited;    //是否编辑(true:编辑,false:未编辑)
@property (nonatomic, strong) NSArray *oPhoneLst;  //其它号码
@property (nonatomic, copy) NSNumber *createTimeL; //创建时间
@end

@interface MyContactBase : LooseJSONModel
@property (nonatomic, strong) NSArray<Contact> *contactLst; //通信记录
@end

@interface MyContact : MyContactBase
@property (nonatomic, copy) NSString *id;  //编号
@property (nonatomic, strong) Login *user; //用户对象,参照/v1/shtapp/base/login返回值
@end

#pragma mark - Request
@interface SaveContactRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId;      //用户编号
@property (nonatomic, copy) NSString *name;     //姓名
@property (nonatomic, copy) NSString *mobile;   //移动电话
@property (nonatomic, copy) NSString *sex;      //性别(0:男,1:女)
@property (nonatomic, copy) NSString *industry; //行业
@property (nonatomic, copy) NSString *icon;     //图像
@end

@interface GetContactRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId; //用户编号
@end

@interface UpdateContactRequest : SaveContactRequest
@property (nonatomic, copy) NSString *id; //修改通讯记录的编号，位置contactLst.id
@end

@interface DeleteContactRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId; //用户编号
@property (nonatomic, copy) NSString *id;  //修改通讯记录的编号，位置contactLst.id
@end

@interface ImportContactRequest : MyContactBase
@property (nonatomic, copy) NSString *uId; //用户编号
@end
