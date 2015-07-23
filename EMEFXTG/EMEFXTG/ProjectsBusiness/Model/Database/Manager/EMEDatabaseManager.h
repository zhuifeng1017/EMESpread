//
//  EMEDatabaseManager.h
//  databaseDemo
//
//  Created by Mac on 14-8-28.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMEDatabase.h"

@interface EMEDatabaseManager : NSObject
+ (EMEDatabaseManager *)sharedInstance;

//Management & Client Side DB
- (EMEDatabase *)emeAppInfoDatabase;

//Management Side DB
- (EMEDatabase *)operatorDatabase;
- (EMEDatabase *)reserveDatabase;
- (EMEDatabase *)areaDatabase;
//Client Side DB
- (EMEDatabase *)favSupplyDatabase;
- (EMEDatabase *)userHistoryDatabase;

// SHT DB
- (EMEDatabase *)noticeMessageDatabase;
- (EMEDatabase *)chatGroupNewInfoDatabase;
- (EMEDatabase *)allUserEntityDatabase;
@end
