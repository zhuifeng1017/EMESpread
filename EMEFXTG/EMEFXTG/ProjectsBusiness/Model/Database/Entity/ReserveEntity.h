//
//  ReserveEntity.h
//  EMEHS-MGT
//
//  Created by Mac on 14-8-30.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "JSONModel.h"
#import "IDatabaseAttributeQuery.h"

@interface ReserveEntity : JSONModel <IDatabaseAttributeQuery>
//服务编号
@property (retain, nonatomic) NSString *reserveId;
@property (retain, nonatomic) NSString *product;
@property (retain, nonatomic) NSString *user;
@property (retain, nonatomic) NSString *number;
@property (retain, nonatomic) NSString *contactor;
@property (retain, nonatomic) NSString *phone;
@property (retain, nonatomic) NSString *status;
@property (retain, nonatomic) NSString *createTime;
@property (retain, nonatomic) NSString *remarkTime;
@end
