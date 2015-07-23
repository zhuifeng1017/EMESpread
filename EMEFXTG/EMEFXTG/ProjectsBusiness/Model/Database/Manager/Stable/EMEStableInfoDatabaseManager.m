//
//  EMEStableInfoDatabaseManager.m
//  EMESHT
//
//  Created by appeme on 14-11-20.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "EMEStableInfoDatabaseManager.h"
#import "EMEDatabaseQueueManager.h"

@interface EMEStableInfoDatabaseManager ()
@property (strong, nonatomic) NSDictionary *entityDatabaseDictionary;
@end

@implementation EMEStableInfoDatabaseManager

+ (instancetype)sharedInstance {
    static EMEStableInfoDatabaseManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[EMEStableInfoDatabaseManager alloc] init];
        
        NSDictionary *tableInfoDictionary = @{
                                              @"emeappinfo" : @"EMEStableAppInfoEntity"
                                              };
        instance.entityDatabaseDictionary = [instance configureDatabase:tableInfoDictionary];
    });

    return instance;
}

- (NSDictionary *)configureDatabase:(NSDictionary *)tableInfoDictionary {
    NSMutableDictionary *entityDatabaseDictionary = [[NSMutableDictionary alloc] initWithCapacity:10];
    NSArray *keys = [tableInfoDictionary allKeys];
    for (NSString *key in keys) {
        NSString *value = [tableInfoDictionary valueForKey:key];
        EMEDatabase *db = [[EMEDatabase alloc] initWithDatabaseQueue:[EMEDatabaseQueueManager sharedInstance].stableInfoQueue table:key entityClass:value];
        [entityDatabaseDictionary setObject:db forKey:key];
    }

    return [entityDatabaseDictionary copy];
}

- (EMEDatabase *)emeAppInfoDatabase {
    return self.entityDatabaseDictionary[@"emeappinfo"];
}
@end
