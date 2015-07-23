//
//  UserGroup.h
//  EMESHT
//
//  Created by appeme on 14-11-13.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "LooseJSONModel.h"
#import "Login.h"

#pragma mark - Base
@interface UserGroup : LooseJSONModel
@property (nonatomic, copy) NSString *id;                //编号
@property (nonatomic, copy) NSString *title;             //标题
@property (nonatomic, strong) Login *user;               //发起的用户
@property (nonatomic, copy) NSString *tag;               //tag
@property (nonatomic, strong) NSArray<Login> *memberLst; //聊天成员编号集合
@property (nonatomic, copy) NSNumber *memberNum;         //组人数
@property (nonatomic, copy) NSNumber *group;             //true:用户组,false:个人
@end

#pragma mark - Request
@interface SaveGroupRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId;        //添加的用户编号
@property (nonatomic, copy) NSArray *memberIdLst; //聊天成员编号集合
@end

@interface UpdateUserGroup : LooseJSONModel
@property (nonatomic, copy) NSString *id;    //编号
@property (nonatomic, copy) NSString *title; //标题
@end

@interface GetGroupRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id; //编号
@end

@interface AddMemberGroupRequest : SaveGroupRequest
@property (nonatomic, copy) NSString *id; //编号
@end

@interface DeleteMemberGroupRequest : AddMemberGroupRequest
@property (nonatomic, copy) NSArray *memberIdLst; //聊天成员编号集合
@end
