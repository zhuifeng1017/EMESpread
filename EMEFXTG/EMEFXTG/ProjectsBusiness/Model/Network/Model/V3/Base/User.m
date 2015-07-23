//
//  User.m
//  EMESHT
//
//  Created by appeme on 14-11-13.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "User.h"

#pragma mark - Base
@implementation User
@end

@implementation WXUser
@end

@implementation WXLogin

@end

#pragma mark - Request
@implementation QueryUserRequest
- (NSString *)requestMethod {
    return @"user/query";
}
@end

@implementation QueryMobileRequest
- (NSString *)requestMethod {
    return @"user/mobile";
}
@end

@implementation WeixinCompleteRequest
- (NSString *)requestMethod {
    return @"user/weixincomplete";
}
@end
