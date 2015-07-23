//
//  Area.h
//  EMEHS-MGT
//
//  Created by appeme on 14-9-11.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "LooseJSONModel.h"

@protocol Area
@end

@interface Area : LooseJSONModel
@property (nonatomic, copy) NSString *id;                //城市编号
@property (nonatomic, copy) NSString *name;              //用户名
@property (nonatomic, strong) NSArray<Area> *subAreaLst; //下辖区域
@end

#pragma mark - Array
@interface Areas : LooseJSONModel
@property (nonatomic, copy) NSArray<Area> *data; //所有城市
@end

#pragma mark - Request

@interface GetAreaRequest : LooseJSONModel
@property (nonatomic, copy) NSString *userid; //用户id
@end