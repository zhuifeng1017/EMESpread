//
//  Calendar.m
//  EMESHT
//
//  Created by xuanhr on 14-12-1.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "Calendar.h"

@implementation Calendar

@end

@implementation SaveCalendarRequest
- (NSString *)requestMethod {
    return @"calendar/save";
}
@end

@implementation UpdateCalendarRequest
- (NSString *)requestMethod {
    return @"calendar/update";
}
@end

@implementation DeleteCalendarRequest
- (NSString *)requestMethod {
    return @"calendar/delete";
}
@end

@implementation QueryCalendarRequest
- (NSString *)requestMethod {
    return @"calendar/query";
}
@end

@implementation AddMemberInviteCalendarRequest
- (NSString *)requestMethod {
    return @"article/addMemeberInvite";
}
@end

@implementation DelMemberInviteCalendarRequest
- (NSString *)requestMethod {
    return @"article/delMemeberInvite";
}
@end