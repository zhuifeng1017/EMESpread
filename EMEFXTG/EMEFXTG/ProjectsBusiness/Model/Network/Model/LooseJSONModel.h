//
//  LooseJSONModel.h
//  EMEHS-MGT
//
//  Created by appeme on 14-9-5.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueryRequestMethod.h"

@interface LooseJSONModel : JSONModel <QueryRequestMethod>
@property (nonatomic, copy) NSNumber *page;     //显示多少页商品,从1开始
@property (nonatomic, copy) NSNumber *pageSize; //一页多少商品
@property (nonatomic, copy) NSNumber *offset;  //查询偏移记录数
@end
