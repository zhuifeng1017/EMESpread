//
//  Param.h
//  EMEHS-MGT
//
//  Created by appeme on 14-9-9.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "LooseJSONModel.h"
@protocol Param <NSObject>
@end

@interface Param : LooseJSONModel
@property (nonatomic, copy) NSString *name;  //产品参数名
@property (nonatomic, copy) NSString *value; //产品参数值
@end
