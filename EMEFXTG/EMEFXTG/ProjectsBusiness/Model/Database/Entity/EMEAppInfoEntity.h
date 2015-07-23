//
//  EMEAppInfoEntity.h
//  EMEHS-MGT
//
//  Created by Mac on 14-9-18.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "JSONModel.h"
#import "IDatabaseAttributeQuery.h"

@interface EMEAppInfoEntity : JSONModel <IDatabaseAttributeQuery>
@property (retain, nonatomic) NSString *id;
@property (retain, nonatomic) NSString *value;

+ (void)putValue:(NSString *)value forKey:(NSString *)key;
+ (NSString *)valueForKey:(NSString *)key;
@end
