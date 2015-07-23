//
//  EMEStableAppInfoEntity.m
//  EMESHT
//
//  Created by appeme on 14-11-20.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "EMEStableAppInfoEntity.h"
#import "EntityHelper.h"
#import "EMEStableInfoDatabaseManager.h"

@implementation EMEStableAppInfoEntity
GEN_QUERYATTRIBUTES

+ (void)putValue:(NSString *)value forKey:(NSString *)key {
    EMEStableAppInfoEntity *entity = [[EMEStableAppInfoEntity alloc] init];
    entity.id = key;
    entity.value = value;

    if (value) {
        [[EMEStableInfoDatabaseManager sharedInstance].emeAppInfoDatabase insert:entity];
    } else {
        [[EMEStableInfoDatabaseManager sharedInstance].emeAppInfoDatabase deleteAll:[NSString stringWithFormat:@"id = '%@' ", key]];
    }
}

+ (NSString *)valueForKey:(NSString *)key {
    NSString *where = [NSString stringWithFormat:@"id='%@'", key];
    NSArray *array = [[EMEStableInfoDatabaseManager sharedInstance].emeAppInfoDatabase selectAll:where];

    if (array.count > 0) {
        EMEStableAppInfoEntity *entity = array[0];
        return entity.value;
    }

    return nil;
}

@end
