//
//  AllUserEntity.h
//  EMESHT
//
//  Created by appeme on 15/2/10.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "JSONModel.h"
#import "IDatabaseAttributeQuery.h"

@interface AllUserEntity : JSONModel <IDatabaseAttributeQuery>
@property (copy, nonatomic) NSString *environmentType;
@property (copy, nonatomic) NSString *uId;
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *userString;
//foreign data
@property (strong, nonatomic) Login *user;
@property (copy, nonatomic) NSString *pinyin;
@property (copy, nonatomic) NSString *pinyinAbbr;
@end
