//
//  EMEDatabaseQueueManager.h
//  databaseDemo
//
//  Created by Mac on 14-8-28.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabaseQueue;

@interface EMEDatabaseQueueManager : NSObject
+ (EMEDatabaseQueueManager *)sharedInstance;
- (FMDatabaseQueue *)defaultQueue;
- (FMDatabaseQueue *)stableInfoQueue;
@end
