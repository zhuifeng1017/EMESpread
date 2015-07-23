//
//  EMEAppInfoEntity.m
//  EMEHS-MGT
//
//  Created by Mac on 14-9-18.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "EMEAppInfoEntity.h"
#import "EntityHelper.h"
#import "EMEDatabaseManager.h"

@implementation EMEAppInfoEntity
GEN_QUERYATTRIBUTES

+ (void)putValue:(NSString *)value forKey:(NSString *)key {
    EMEAppInfoEntity *entity = [[EMEAppInfoEntity alloc] init];
    entity.id = key;
    entity.value = value;

    if (value) {
        [[EMEDatabaseManager sharedInstance].emeAppInfoDatabase insert:entity];
    } else {
        [[EMEDatabaseManager sharedInstance].emeAppInfoDatabase deleteAll:[NSString stringWithFormat:@"id = '%@' ", key]];
    }
}

+ (NSString *)valueForKey:(NSString *)key {
    NSString *where = [NSString stringWithFormat:@"id='%@'", key];
    NSArray *array = [[EMEDatabaseManager sharedInstance].emeAppInfoDatabase selectAll:where];

    if (array.count > 0) {
        EMEAppInfoEntity *entity = array[0];
        return entity.value;
    }

    return nil;
}

@end
