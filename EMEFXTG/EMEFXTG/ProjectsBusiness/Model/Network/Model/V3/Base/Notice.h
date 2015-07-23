//
//  Notice.h
//  EMEZL
//
//  Created by apple on 15/4/23.
//  Copyright (c) 2015年 appeme. All rights reserved.
//

#import "LooseJSONModel.h"

@interface Notice : LooseJSONModel

@property (nonatomic, copy) NSString *id;      //编号
@property (nonatomic, copy) NSString *title;   //标题
@property (nonatomic, copy) NSString *phone;   // 联系电话
@property (nonatomic, copy) NSString *time;    //时间
@property (nonatomic, copy) NSString *address; //地点

@property (nonatomic, strong) NSArray *imgLst;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *remark; // 备注

@property (nonatomic, strong) User *creator; // 创建用户

@property (nonatomic, copy) NSString *createTime; // 创建时间

@end

#pragma mark - Request

@interface QueryNoticeRequest : LooseJSONModel
//@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSString *refId;

@end
