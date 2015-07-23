//
//  EMEStableAppInfoEntity.h
//  EMESHT
//
//  Created by appeme on 14-11-20.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "JSONModel.h"
#import "IDatabaseAttributeQuery.h"

@interface EMEStableAppInfoEntity : JSONModel <IDatabaseAttributeQuery>
@property (retain, nonatomic) NSString *id;
@property (retain, nonatomic) NSString *value;

+ (void)putValue:(NSString *)value forKey:(NSString *)key;
+ (NSString *)valueForKey:(NSString *)key;
@end