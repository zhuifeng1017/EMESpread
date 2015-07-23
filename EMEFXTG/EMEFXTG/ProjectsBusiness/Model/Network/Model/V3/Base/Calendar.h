//
//  Calendar.h
//  EMESHT
//
//  Created by xuanhr on 14-12-1.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "LooseJSONModel.h"
#import <Foundation/Foundation.h>
#import "Login.h"
#import "Content.h"

@interface Calendar : LooseJSONModel
@property (nonatomic, copy) NSString *id;                //编号
@property (nonatomic, copy) NSString *tag;               //标志,'schedule':日程,'invite':邀约
@property (nonatomic, copy) Content *content;            //内容
@property (nonatomic, copy) NSString *memberNum;         //组人数
@property (nonatomic, copy) NSString *fromTime;          //开始时间
@property (nonatomic, copy) NSString *toTime;            //结束日期
@property (nonatomic, strong) Login *from;               //创建日程/邀约用户对象
@property (nonatomic, strong) Login *to;                 //邀约用户对象
@property (nonatomic, strong) Login *owner;              //日程所有用户（创建用户）对象
@property (nonatomic, strong) NSArray<Login> *memberLst; //邀约成员
@property (nonatomic, copy) NSString *chatGroupId;       //聊天组编号
@property (nonatomic, copy) NSString *createTime;        //创建时间
@property (nonatomic, copy) NSString *hasNext;           //是否还有记录，true:还有记录
@property (nonatomic, copy) NSArray *alert;              //提示时间，单位为分
@end

@interface SaveCalendarRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId;        //用户编号
@property (nonatomic, copy) NSString *content;    //日程内容
@property (nonatomic, copy) NSString *address;    //邀约地址
@property (nonatomic, copy) NSString *tag;        //日程类型,'schedule':日程,'invite':邀约
@property (nonatomic, copy) NSArray *alert;       //提示时间，单位为分
@property (nonatomic, copy) NSString *fromTime;   //开始时间,格式yyyy-MM-dd HH:mm:ss
@property (nonatomic, copy) NSString *toTime;     //结束时间,格式yyyy-MM-dd HH:mm:ss
@property (nonatomic, copy) NSArray *memberIdLst; //邀约人集合
@end

@interface UpdateCalendarRequest : SaveCalendarRequest
@property (nonatomic, copy) NSString *uId; //用户编号
@end

@interface DeleteCalendarRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId; //用户编号
@property (nonatomic, copy) NSString *id;  //日程编号
@property (nonatomic, copy) NSString *tag; //标志,'schedule':日程,'invite':邀约

@end

@interface QueryCalendarRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId;      //用户编号
@property (nonatomic, copy) NSString *lastTime; //最后请求时间

@end

@interface AddMemberInviteCalendarRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId;      //用户编号
@property (nonatomic, copy) NSString *id;       //日程编号
@property (nonatomic, copy) NSArray *memberLst; //邀约人集合
@end

@interface DelMemberInviteCalendarRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId; //退出用户编号
@property (nonatomic, copy) NSString *id;  //编号
@end
