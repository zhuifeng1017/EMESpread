//
//  Activity.m
//  EMEZL
//
//  Created by apple on 15/4/22.
//  Copyright (c) 2015年 appeme. All rights reserved.
//

#import "Activity.h"
@implementation BaseActivity
@end

@implementation Activity
@end

@implementation ActivityProject
@end

@implementation ApplyActivityResponse
@end

@implementation SaveActivityRequest
- (NSString *)requestMethod {
    return @"activity/save";
}
@end

@implementation UpdateActivityRequest
- (NSString *)requestMethod {
    return @"activity/update";
}
@end

@implementation QueryActivityRequest
- (NSString *)requestMethod {
    return @"activity/query";
}
@end

@implementation QueryMyActivityRequest
- (NSString *)requestMethod {
    return @"activity/myactivity";
}
@end

@implementation QueryMyFavActivityRequest
- (NSString *)requestMethod {
    return @"activity/myhistory";
}
@end

@implementation SaveActivityCommentRequest
- (NSString *)requestMethod {
    return @"activity/comment";
}
@end

@implementation QueryActivityCommentRequest
- (NSString *)requestMethod {
    return @"activity/queryComment";
}
@end

@implementation PraiseActivityRequest
- (NSString *)requestMethod {
    return @"activity/praise";
}
@end

@implementation ActivityApplyRequest
- (NSString *)requestMethod {
    return @"activity/apply";
}
@end

@implementation QueryActivityApplyRequest
- (NSString *)requestMethod {
    return @"activity/queryApply";
}
@end

@implementation StarActivityRequest
- (NSString *)requestMethod {
    return @"activity/history";
}
@end

@implementation UnStarActivityRequest
- (NSString *)requestMethod {
    return @"history/delete";
}
@end

@implementation UnStarActivityResponse
@end

@implementation GetActivityRequest
- (NSString *)requestMethod {
    return @"activity/get";
}
@end
