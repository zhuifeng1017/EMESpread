//
//  Chat.m
//  EMESHT
//
//  Created by appeme on 14-11-14.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "Chat.h"

#pragma mark - Base

@implementation Subject
@end

@implementation Chat
@end

#pragma mark - Request
@implementation QueryChatRequest
- (NSString *)requestMethod {
    return @"chat/query";
}
@end

@implementation SendChatRequest
- (NSString *)requestMethod {
    return @"chat/chat";
}
@end

@implementation SayHiRequest
- (NSString *)requestMethod {
    return @"hi/send";
}
@end
