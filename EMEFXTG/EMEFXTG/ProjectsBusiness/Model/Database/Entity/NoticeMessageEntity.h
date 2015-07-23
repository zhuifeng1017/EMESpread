//
//  NoticeMessageEntity.h
//  EMESHT
//
//  Created by appeme on 14-11-14.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDatabaseAttributeQuery.h"

@interface NoticeMessageEntity : JSONModel <IDatabaseAttributeQuery>
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *uId;     //编号(用户编号)
@property (nonatomic, copy) NSString *fromId;  //编号(用户或组编号)
@property (nonatomic, copy) NSString *msgFrom; //Login*
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *tag;     //消息标志，通过消息标志可决定消息处理方法
@property (nonatomic, copy) NSString *title;   //消息标题
@property (nonatomic, copy) NSString *desc;    //消息内容
@property (nonatomic, copy) NSString *message; //消息对象，不同类型的消息格式可能不同
@end
