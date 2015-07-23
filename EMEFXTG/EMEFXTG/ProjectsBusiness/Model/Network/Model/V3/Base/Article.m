//
//  Article.m
//  EMESHT
//
//  Created by appeme on 14-11-12.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "Article.h"

#pragma mark - Base
@implementation Article
@end

@implementation Comment
@end

#pragma mark - Request
@implementation SaveArticleRequest
- (NSString *)requestMethod {
    return @"article/save";
}
@end

@implementation PraiseArticleRequest
- (NSString *)requestMethod {
    return @"article/praise";
}
@end

@implementation GetArticleRequest
- (NSString *)requestMethod {
    return @"article/get";
}
@end

// ------------------------------------------------
@implementation UpdateArticleRequest
- (NSString *)requestMethod {
    return @"article/update";
}
@end

@implementation DeleteArticleRequest
- (NSString *)requestMethod {
    return @"article/delete";
}
@end



@implementation QueryArticleRequest
- (NSString *)requestMethod {
    return @"article/query";
}
@end

@implementation ShareArticleRequest
- (NSString *)requestMethod {
    return @"article/share";
}
@end

@implementation SaveArticleCommentRequest
- (NSString *)requestMethod {
    return @"article/comment";
}
@end

@implementation GetArticleCommentRequest
- (NSString *)requestMethod {
    return @"article/getComment";
}
@end

@implementation HistoryRequest
- (NSString *)requestMethod {
    return @"article/history";
}
@end