//
//  Friend.m
//  EMESHT
//
//  Created by appeme on 14-11-13.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "Friend.h"

#pragma mark - Base
@implementation Friend
@end
@implementation MyFriend
@end

#pragma mark - Request
@implementation SaveFriendRequest
- (NSString *)requestMethod {
    return @"friend/save";
}
@end

@implementation DeleteFriendRequest
- (NSString *)requestMethod {
    return @"friend/delete";
}
@end

@implementation GetFriendRequest
- (NSString *)requestMethod {
    return @"friend/get";
}
@end

@implementation PassFriendRequest
- (NSString *)requestMethod {
    return @"friend/pass";
}
@end

@implementation RefuseFriendRequest
- (NSString *)requestMethod {
    return @"friend/refuse";
}
@end
