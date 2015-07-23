//
//  version.h
//  EMEHS-MGT
//
//  Created by xuanhr on 14-9-9.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "LooseJSONModel.h"

@interface Version : LooseJSONModel
@property (nonatomic, copy) NSString *id;        //系统ID
@property (nonatomic, copy) NSString *appCode;   //app编号,区分app标示
@property (nonatomic, copy) NSString *appName;   //app名称
@property (nonatomic, copy) NSString *appVer;    //app版本
@property (nonatomic, copy) NSNumber *appVerNum; //app版本号
@property (nonatomic, copy) NSString *appDesc;   //新版本描述
@property (nonatomic, copy) NSString *appUrl;    //下载位置
@property (nonatomic, copy) NSString *os;        //操作系统
@end

@interface FindVersionRequest : Version
@property (nonatomic, copy) NSNumber *isCount;  //显示查询记录总数
@property (nonatomic, copy) NSNumber *page;     //显示多少页,从1开始
@property (nonatomic, copy) NSNumber *pageSize; //一页多少记录

@end

@interface SaveVersionRequest : Version
@property (nonatomic, copy) NSString *sdk; //支持sdk

@end

@interface DeleteVersionRequest : Version
@property (nonatomic, copy) NSArray *ids; //编号集合

@end

@interface CheckVersionRequest : LooseJSONModel
@property (nonatomic, copy) NSString *appCode;   //app编号,区分app标示
@property (nonatomic, copy) NSString *os;        //操作系统
@property (nonatomic, copy) NSString *appVerNum; //当前app版本号
@end