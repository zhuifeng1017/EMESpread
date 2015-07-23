//
//  Resource.m
//  EMESHT
//
//  Created by xuanhr on 15/2/2.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "Resource.h"

@implementation Resource
@end

@implementation Priase
@end

@implementation CommentDetail
@end

@implementation PriaseDetail
@end

@implementation SaveResourceRequest
- (NSString *)requestMethod {
    return @"resource/save";
}
@end

@implementation UpdateResourceRequest
- (NSString *)requestMethod {
    return @"resource/update";
}
@end

@implementation QueryResourceRequest
- (NSString *)requestMethod {
    return @"resource/query";
}
@end

@implementation DeleteResourceRequest
- (NSString *)requestMethod {
    return @"resource/delete";
}
@end

@implementation ResourcePraiseRequest
- (NSString *)requestMethod {
    return @"resource/praise";
}
@end

@implementation QueryPraiseRequest
- (NSString *)requestMethod {
    return @"resource/queryPraise";
}
@end

@implementation ResourceCommentRequest
- (NSString *)requestMethod {
    return @"resource/comment";
}
@end

@implementation CommentReplyRequest
- (NSString *)requestMethod {
    return @"comment/reply";
}
@end

@implementation QueryCommentRequest
- (NSString *)requestMethod {
    return @"comment/query";
}

@end