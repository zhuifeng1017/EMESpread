//
//  ChatGroupNewInfoEntity.h
//  EMESHT
//
//  Created by appeme on 14/12/23.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDatabaseAttributeQuery.h"

@interface ChatGroupNewInfoEntity : JSONModel <IDatabaseAttributeQuery>
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *uId;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *freshInfoCount;
@end
