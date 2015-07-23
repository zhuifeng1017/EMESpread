//
//  UserGroup.m
//  EMESHT
//
//  Created by appeme on 14-11-13.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "UserGroup.h"

#pragma mark - Base
@implementation UserGroup
@end

#pragma mark - Request
@implementation SaveGroupRequest
- (NSString *)requestMethod {
    return @"chat/saveGroup";
}
@end

@implementation UpdateUserGroup
- (NSString *)requestMethod {
    return @"chat/updateGroup";
}
@end

@implementation GetGroupRequest
- (NSString *)requestMethod {
    return @"chat/getGroup";
}
@end

@implementation AddMemberGroupRequest
- (NSString *)requestMethod {
    return @"chat/addMemberGroup";
}
@end

@implementation DeleteMemberGroupRequest
- (NSString *)requestMethod {
    return @"chat/delMemberGroup";
}
@end
