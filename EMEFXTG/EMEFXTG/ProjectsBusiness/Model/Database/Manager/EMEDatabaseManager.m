//
//  EMEDatabaseManager.m
//  databaseDemo
//
//  Created by Mac on 14-8-28.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "EMEDatabaseManager.h"
#import "EMEDatabaseQueueManager.h"

@interface EMEDatabaseManager ()
@property (strong, nonatomic) NSDictionary *entityDatabaseDictionary;
@end

@implementation EMEDatabaseManager

+ (EMEDatabaseManager *)sharedInstance {
    static EMEDatabaseManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[EMEDatabaseManager alloc] init];
        
        NSDictionary *tableInfoDictionary = @{@"operator" : @"OperatorEntity",
                                              @"reserve" : @"ReserveEntity",
                                              @"area" : @"AreaEntity",
                                              @"emeappinfo" : @"EMEAppInfoEntity",
                                              @"favsupply" : @"FavSupplyEntity",
                                              @"noticemessage" : @"NoticeMessageEntity",
                                              @"chatgroupnewinfo" : @"ChatGroupNewInfoEntity",
                                              @"alluser" :@"AllUserEntity"
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
        EMEDatabase *db = [[EMEDatabase alloc] initWithDatabaseQueue:[EMEDatabaseQueueManager sharedInstance].defaultQueue table:key entityClass:value];
        [entityDatabaseDictionary setObject:db forKey:key];
    }

    return [entityDatabaseDictionary copy];
}

- (EMEDatabase *)operatorDatabase {
    return self.entityDatabaseDictionary[@"operator"];
}

- (EMEDatabase *)reserveDatabase {
    return self.entityDatabaseDictionary[@"reserve"];
}

- (EMEDatabase *)areaDatabase {
    return self.entityDatabaseDictionary[@"area"];
}

- (EMEDatabase *)emeAppInfoDatabase {
    return self.entityDatabaseDictionary[@"emeappinfo"];
}

- (EMEDatabase *)favSupplyDatabase {
    return self.entityDatabaseDictionary[@"favsupply"];
}

- (EMEDatabase *)userHistoryDatabase {
    return self.entityDatabaseDictionary[@"userhistory"];
}

- (EMEDatabase *)noticeMessageDatabase {
    return self.entityDatabaseDictionary[@"noticemessage"];
}

- (EMEDatabase *)chatGroupNewInfoDatabase {
    return self.entityDatabaseDictionary[@"chatgroupnewinfo"];
}

- (EMEDatabase *)allUserEntityDatabase {
    return self.entityDatabaseDictionary[@"alluser"];
}

@end
