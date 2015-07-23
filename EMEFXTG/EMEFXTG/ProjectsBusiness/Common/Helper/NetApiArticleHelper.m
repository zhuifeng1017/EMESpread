//
//  ArticleHelper.m
//  EMESHT
//
//  Created by appeme on 14-12-2.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "NetApiArticleHelper.h"
#import "AppCacheManager.h"

@interface NetApiArticleHelper ()
@end

@implementation NetApiArticleHelper

+ (void)saveArticle:(SaveArticleRequest *)request withBlock:(GetArticleBlock)block {
    GetArticleBlock blk = [block copy];

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            blk(@"success", response);
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:Article.class loadingTip:NO errorTip:NO];
}

+ (void)updateArticle:(UpdateArticleRequest *)request withBlock:(GetArticleBlock)block {
    GetArticleBlock blk = [block copy];

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            blk(@"success", response);
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:Article.class loadingTip:NO errorTip:NO];
}

+ (void)queryArticle:(NSString *)socialGroupId withBlock:(QueryArticleBlock)block {
    QueryArticleBlock blk = [block copy];
    
    QueryArticleRequest *request = [[QueryArticleRequest alloc] init];
    request.gId = socialGroupId;
    
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;
    
    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            blk(@"success", response);
        }
        else {
            blk(@"fail", nil);
        }
    }];
    
    [weakEmeHttpRequest sendRequest:Article.class loadingTip:NO errorTip:NO];
}

+ (void)getArticle:(NSString *)articleId withBlock:(GetArticleBlock)block {
    GetArticleBlock blk = [block copy];

    GetArticleRequest *request = [[GetArticleRequest alloc] init];
    request.id = articleId;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            blk(@"success", response);
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:Article.class loadingTip:NO errorTip:NO];
}

+ (void)deleteArticle:(NSArray *)articleIds withBlock:(DeleteArticleBlock)block {
    DeleteArticleBlock blk = [block copy];

    DeleteArticleRequest *request = [[DeleteArticleRequest alloc] init];
    request.uId = [AppCacheManager sharedManager].loginUserId;
    request.idLst = articleIds;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"删除成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success");
            }];
        }
        else {
            blk(@"fail");
        }
    }];

    [weakEmeHttpRequest sendRequest:JSONModel.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)shareArticle:(NSString *)articleId toUsers:(NSArray *)uIds withBlock:(ShareArticleBlock)block {
    ShareArticleBlock blk = [block copy];

    ShareArticleRequest *request = [[ShareArticleRequest alloc] init];
    request.id = articleId;
    request.uId = [AppCacheManager sharedManager].loginUserId;
    request.uIdLst = uIds;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"共享成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success");
            }];
        }
        else {
            blk(@"fail");
        }
    }];

    [weakEmeHttpRequest sendRequest:JSONModel.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)saveComment:(NSString *)comment forArticleId:(NSString *)articleId withBlock:(CommentBlock)block {
    CommentBlock blk = [block copy];

    SaveArticleCommentRequest *request = [[SaveArticleCommentRequest alloc] init];
    request.id = articleId;
    request.uId = [AppCacheManager sharedManager].loginUserId;
    request.content = comment;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            Comment *comment = response;
            [weakEmeHttpRequest setProgressMessage:@"评论成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", comment);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:Comment.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)getCommentByArticleId:(NSString *)articleId withBlock:(GetCommentBlock)block {
    GetCommentBlock blk = [block copy];

    GetArticleCommentRequest *request = [[GetArticleCommentRequest alloc] init];
    request.id = articleId;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            NSArray *comments = response;
            blk(@"success", comments);
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:Comment.class loadingTip:NO errorTip:NO];
}

+ (void)savePraise:(NSString *)articleId byUserId:(NSString *)userId withBlock:(GetArticleBlock)block {
    GetArticleBlock blk = [block copy];

    PraiseArticleRequest *request = [[PraiseArticleRequest alloc] init];
    request.id = articleId;
    request.uId = userId;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            blk(@"success", response);
        }
        else {
            blk(@"fail", nil);
        }

    }];

    [weakEmeHttpRequest sendRequest:Article.class loadingTip:NO errorTip:NO];
}
@end
