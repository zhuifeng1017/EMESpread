//
//  EMEDatabaseQueueManager.m
//  databaseDemo
//
//  Created by Mac on 14-8-28.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "EMEDatabaseQueueManager.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "EMEConfigManager.h"

#define FMDBQuickCheck(value)                         \
    {                                                 \
        if (!(value)) {                               \
            NSLog_e(@"Failure on line %d", __LINE__); \
            abort();                                  \
        }                                             \
    }

@interface EMEDatabaseQueueManager () {
    NSMutableDictionary *databaseQueues;
}
@end

@implementation EMEDatabaseQueueManager

+ (EMEDatabaseQueueManager *)sharedInstance {
    static EMEDatabaseQueueManager *instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[EMEDatabaseQueueManager alloc] init];
    });

    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        databaseQueues = [[NSMutableDictionary alloc] initWithCapacity:3];
        [databaseQueues setObject:[self createDefaultQueue] forKey:@"default"];
        [databaseQueues setObject:[self createStableInfoQueue] forKey:@"stableInfoQueue"];
    }
    return self;
}

- (FMDatabaseQueue *)defaultQueue {
    return [databaseQueues objectForKey:@"default"];
}

- (FMDatabaseQueue *)createDefaultQueue {
    __block FMDatabaseQueue *dbQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *dbFileName = [NSString stringWithFormat:@"EMEAPP%@.sqlite", [[EMEConfigManager shareConfigManager] getAppDatabaseVersion]];
        NSString *dbFilePath = [self dbFilePath:dbFileName];
        dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
        FMDBQuickCheck(dbQueue);
        
        NSArray *createTables = @[
                                  //operator
                                  @"create table if not exists 'operator' ('operatorId' varchar primary key not null unique, 'loginName' varchar, 'name' varchar, 'password' varchar, 'mobile' varchar, 'sCode' varchar,'postCode' varchar, 'company' varchar, 'email' varchar, 'qq' varchar, 'fax' varchar, 'address' varchar)",

                                  //reserve
                                  @"create table if not exists 'reserve' ('reserveId' varchar primary key not null unique, 'product' varchar, 'user' varchar, 'number' integer, 'contactor' varchar, 'phone' varchar,'status' varchar, 'createTime' varchar, 'remarkTime' varchar)",
                                  
                                  //area
                                  @"create table if not exists 'area' ('id' varchar primary key not null unique, 'parentId' varchar, 'name' varchar)",
                                  
                                  //emeappinfo
                                  @"create table if not exists 'emeappinfo' ('id' varchar primary key not null unique, 'value' varchar)",
                                  
                                  //favsupply
                                  @"create table if not exists 'favsupply' ('id' varchar primary key not null unique, 'icon' varchar)",
                                  
                                  //userhistory
                                  @"create table if not exists 'userhistory' ('id' varchar primary key not null unique, 'type' varchar)",
                                  
                                  //noticemessage
//                                  @"create table if not exists 'noticemessage' (id integer primary key autoincrement, 'uid' varchar, 'createtime' varchar, 'tag' varchar, 'message' varchar)"
                                  @"create table if not exists 'noticemessage' ('id' varchar primary key not null unique, 'uid' varchar, 'fromid' varchar, 'msgfrom' varchar, 'createtime' varchar, 'tag' varchar, 'title' varchar, 'desc' varchar, 'message' varchar)",
                                  @"create index tagindex on noticemessage (tag)",
                                  
                                  //chatgroupnewinfo
                                  @"create table if not exists 'chatgroupnewinfo' ('id' varchar primary key not null unique, 'uid' varchar, 'type' varchar, 'freshinfocount' varchar)",
                                  
                                  //alluser
                                  @"create table if not exists 'alluser' ('environmentType' varchar, 'uid' varchar, 'mobile' varchar, 'userstring' varchar, primary key (environmentType, uid))"
                                  ];

        
        [self initTables:dbQueue withSqls:createTables];
    });

    return dbQueue;
}

- (FMDatabaseQueue *)stableInfoQueue {
    return [databaseQueues objectForKey:@"stableInfoQueue"];
}

- (FMDatabaseQueue *)createStableInfoQueue {
    __block FMDatabaseQueue *dbQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *dbFilePath = [self dbFilePath:@"EMEAPP-stable.sqlite"];
        dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
        FMDBQuickCheck(dbQueue);
        
        NSArray *createTables = @[
                                  //emeappinfo
                                  @"create table if not exists 'emeappinfo' ('id' varchar primary key not null unique, 'value' varchar)"
                                  ];
        
        [self initTables:dbQueue withSqls:createTables];
    });

    return dbQueue;
}

- (NSString *)dbFilePath:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:name];

    NSLog_i(@"EME Database path: %@", dbPath);

    return dbPath;
}

- (void)initTables:(FMDatabaseQueue *)dbQueue withSqls:(NSArray *)sqls {
    [dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (NSString *createTable in sqls) {
            [db executeUpdate:createTable];
        }
    }];
}

@end
