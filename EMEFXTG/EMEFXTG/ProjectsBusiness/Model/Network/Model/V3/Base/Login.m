//
//  Login.m
//  EMESHT
//
//  Created by appeme on 14-11-11.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "Login.h"

@implementation Person
@end
@implementation Login
@end
@implementation Company
@end
@implementation Job
@end
@implementation AllocSocket
@end

#pragma mark - Request
@implementation LoginRequest
- (NSString *)requestMethod {
    return @"base/login";
}
@end

@implementation WXLoginRequest
- (NSString *)requestMethod {
    return @"base/loginwx";
}
@end

@implementation LoginOutRequest
- (NSString *)requestMethod {
    return @"base/logout";
}
@end

@implementation RegisterRequest
- (NSString *)requestMethod {
    return @"base/register";
}
@end

@implementation UpdateInfoRequest
- (NSString *)requestMethod {
    return @"user/update";
}
@end

@implementation CompleteInfoRequest
- (NSString *)requestMethod {
    return @"user/complete";
}
@end

@implementation UpdatePasswordRequest
- (NSString *)requestMethod {
    return @"user/passwordUpdate";
}
@end

@implementation AllocSocketRequest
- (NSString *)requestMethod {
    return @"user/allocSocket";
}
@end

@implementation RefreshRongTokenRequest
- (NSString *)requestMethod {
    return @"user/refreshRongToken";
}
@end