//
//  SocialGroup.m
//  EMESHT
//
//  Created by appeme on 15/3/5.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "SocialGroup.h"

#pragma mark - Base
@implementation SocialGroup
@end

@implementation GetSocialGroupInviteResponse
@end

@implementation SocialGroupMember
@end

#pragma mark - Request
@implementation SaveSocialGroupRequest
- (NSString *)requestMethod {
    return @"group/save";
}
@end

@implementation UpdateSocialGroupRequest
- (NSString *)requestMethod {
    return @"group/update";
}
@end

@implementation QuerySocialGroupRequest
- (NSString *)requestMethod {
    return @"group/query";
}
@end

@implementation ApplySocialGroupRequest
- (NSString *)requestMethod {
    return @"group/apply";
}
@end

@implementation InviteSocialGroupRequest
- (NSString *)requestMethod {
    return @"group/invite";
}
@end

@implementation PassApplySocialGroupRequest
- (NSString *)requestMethod {
    return @"group/passApply";
}
@end

@implementation PassInviteSocialGroupRequest
- (NSString *)requestMethod {
    return @"group/passInvite";
}
@end

@implementation RefuseApplySocialGroupRequest
- (NSString *)requestMethod {
    return @"group/refuseApply";
}
@end

@implementation RefuseInviteSocialGroupRequest
- (NSString *)requestMethod {
    return @"group/refuseInvite";
}
@end

@implementation AdminSocialGroupRequest
- (NSString *)requestMethod {
    return @"group/admin";
}
@end

@implementation GetApplySocialGroupRequest
- (NSString *)requestMethod {
    return @"group/getApply";
}
@end

@implementation GetInviteSocialGroupRequest
- (NSString *)requestMethod {
    return @"group/getInvite";
}
@end

@implementation GetMemberSocialGroupRequest
- (NSString *)requestMethod {
    return @"group/getMember";
}
@end

@implementation MySocialGroupRequest
- (NSString *)requestMethod {
    return @"group/my";
}
@end

@implementation ExitSocialGroupRequest
- (NSString *)requestMethod {
    return @"group/exit";
}
@end

@implementation DeleteMemberSocialGroupRequest
- (NSString *)requestMethod {
    return @"group/deleteMember";
}
@end

#pragma mark - 圈子公告
@implementation SocialGroupAnnounce
@end

@implementation SaveSocialGroupAnnounceRequest
- (NSString *)requestMethod {
    return @"gnotice/save";
}

@end

@implementation UpdateSocialGroupAnnounceRequest
- (NSString *)requestMethod {
    return @"gnotice/update";
}
@end

@implementation QuerySocialGroupAnnounceRequest
- (NSString *)requestMethod {
    return @"gnotice/query";
}
@end

@implementation DeleteSocialGroupAnnounceRequest
- (NSString *)requestMethod {
    return @"gnotice/delete";
}
@end

#pragma mark - 圈子发言
@implementation Speak
@end

@implementation SaveSpeakRequest
- (NSString *)requestMethod {
    return @"gspeak/save";
}
@end

@implementation UpdateSpeakRequest
- (NSString *)requestMethod {
    return @"gspeak/update";
}
@end

@implementation QuerySpeakRequest
- (NSString *)requestMethod {
    return @"gspeak/query";
}
@end

@implementation deleteSpeakRequest
- (NSString *)requestMethod {
    return @"gspeak/delete";
}
@end

@implementation SaveSocialGroupNoticeRequest

- (NSString *)requestMethod {
    return @"group/saveNotice";
}
@end

@implementation SaveSocialGroupNoticeResponse
@end
