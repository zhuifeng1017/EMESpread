//
//  FriendHelper.h
//  EMESHT
//
//  Created by xuanhr on 14/12/18.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Friend.h"
#import "AppCacheManager.h"

typedef void (^AddFriendBlock)(NSString *message);
typedef void (^GetFriendBlock)(NSString *message, NSArray *friendLst);

@interface NetApiFriendHelper : NSObject
+ (void)addFriendWithFriendId:(NSString *)friendId withBlock:(AddFriendBlock)block;
//- (void)passFriendWithFriendId:(NSString *)friendId andMessageId:(NSString *)megId withBlock:(AddFriendBlock)block;
//- (void)refuseFriendWithFriendId:(NSString *)friendId andMessageId:(NSString *)megId withBlock:(AddFriendBlock)block;
+ (void)getFriendWithUId:(NSString *)uId withBlock:(GetFriendBlock)block;
+ (void)deleteFriendWithFId:(NSString *)fId withBlock:(GetFriendBlock)block;

@end
