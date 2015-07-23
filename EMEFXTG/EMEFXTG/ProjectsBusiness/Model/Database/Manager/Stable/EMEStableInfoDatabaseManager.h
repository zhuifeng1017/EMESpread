//
//  EMEStableInfoDatabaseManager.h
//  EMESHT
//
//  Created by appeme on 14-11-20.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMEDatabase.h"

@interface EMEStableInfoDatabaseManager : NSObject
+ (instancetype)sharedInstance;
- (EMEDatabase *)emeAppInfoDatabase;
@end
