//
//  AreaEntity.h
//  EMEHS-MGT
//
//  Created by appeme on 14-9-11.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "JSONModel.h"
#import "IDatabaseAttributeQuery.h"

@interface AreaEntity : JSONModel <IDatabaseAttributeQuery>
@property (retain, nonatomic) NSString *id;       //城市编号
@property (retain, nonatomic) NSString *parentId; //父编号
@property (retain, nonatomic) NSString *name;     //name
@end
