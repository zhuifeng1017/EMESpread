//
//  Message.h
//  EMESHT
//
//  Created by appeme on 14-11-13.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "LooseJSONModel.h"

#pragma mark - Base
@interface MessageLogger : LooseJSONModel
@property (nonatomic, copy) NSString *id;          //消息编号
@property (nonatomic, copy) NSString *uId;         //用户编号
@property (nonatomic, copy) NSString *tag;         //消息标志，通过消息标志可决定消息处理方法
@property (nonatomic, copy) NSDictionary *from;    //发送用户
@property (nonatomic, copy) NSString *title;       //消息标题
@property (nonatomic, copy) NSDictionary *desc;    //消息内容
@property (nonatomic, copy) NSDictionary *msg;     //消息对象，不同类型的消息格式可能不同
@property (nonatomic, copy) NSString *createTime;  //创建时间,格式化时间
@property (nonatomic, copy) NSNumber *createTimeL; //创建时间
@end

#pragma mark - Request
@interface GetMessageRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId; //用户编号
@end

@interface SyncMessageLoggerRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId;       //用户编号
@property (nonatomic, copy) NSNumber *lastTimeL; //上传数据接收时间，查询该日期后的数据,如无最后上传时间传'-1'
@end

@interface SyncCalendarLoggerRequest: SyncMessageLoggerRequest
@end
