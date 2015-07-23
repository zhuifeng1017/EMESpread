//
//  Friend.h
//  EMESHT
//
//  Created by appeme on 14-11-13.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "LooseJSONModel.h"
#import "Login.h"

#pragma mark - Base
@protocol Friend
@end

@interface Friend : LooseJSONModel
@property (nonatomic, strong) Login *friend;                   //用户
@property (nonatomic, copy) NSString *status;                  //好友状态,0:为验证通过,1:验证通过
@property (nonatomic, copy) NSNumber *createTime;              //创建时间
@property (nonatomic, copy) NSString<Ignore> *pinyin;          //拼音
@property (nonatomic, copy) NSString<Ignore> *pinyinIndexChar; //拼音索引

@end

@interface MyFriend : LooseJSONModel
@property (nonatomic, copy) NSString *id;               //编号
@property (nonatomic, strong) Login *user;              //编号
@property (nonatomic, copy) NSArray<Friend> *friendLst; //描述列表
@end

#pragma mark - Request
@interface SaveFriendRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId; //用户编号
@property (nonatomic, copy) NSString *fId; //添加好友用户编号
@property (nonatomic, copy) NSString *mId; //消息编号，操作成功删除该消息
@end

@interface DeleteFriendRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId;   //用户编号
@property (nonatomic, copy) NSArray *fIdLst; //删除好友用户编号集合

@end

@interface GetFriendRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId; //用户编号
@end

@interface PassFriendRequest : SaveFriendRequest
@end

@interface RefuseFriendRequest : SaveFriendRequest
@end
