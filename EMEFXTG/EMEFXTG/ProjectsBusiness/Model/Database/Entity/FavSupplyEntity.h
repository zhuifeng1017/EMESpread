//
//  FavSupplyEntity.h
//  EMEHS
//
//  Created by appeme on 14-9-25.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "JSONModel.h"
#import "IDatabaseAttributeQuery.h"

@interface FavSupplyEntity : JSONModel <IDatabaseAttributeQuery>
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *icon;
@end
