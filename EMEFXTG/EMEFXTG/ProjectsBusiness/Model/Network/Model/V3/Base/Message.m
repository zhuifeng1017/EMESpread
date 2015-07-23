//
//  Message.m
//  EMESHT
//
//  Created by appeme on 14-11-13.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "Message.h"

#pragma mark - Base
@implementation MessageLogger
@end

#pragma mark - Request
@implementation GetMessageRequest
- (NSString *)requestMethod {
    return @"message/get";
}
@end

@implementation SyncMessageLoggerRequest
- (NSString *)requestMethod {
    return @"init/syncMessage";
}
@end

@implementation SyncCalendarLoggerRequest
- (NSString *)requestMethod {
    return @"init/syncCalendar";
}
@end
