//
//  NetApiResourceHelper.m
//  EMESHT
//
//  Created by xuanhr on 15/2/2.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "NetApiResourceHelper.h"
#import "EMEHttpRequest.h"

@interface NetApiResourceHelper ()
@end

@implementation NetApiResourceHelper
+ (void)saveResourceRequest:(SaveResourceRequest *)request withBlock:(NetApiResourceBlock)block {
    NetApiResourceBlock blk = [block copy];
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;
    
    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"保存成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", nil);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];
    
    [weakEmeHttpRequest sendRequest:Resource.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)updateResourceRequest:(UpdateResourceRequest *)request withBlock:(NetApiResourceBlock)block {
    NetApiResourceBlock blk = [block copy];
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;
    
    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            blk(@"success", nil);
        }
        else {
            blk(@"fail", nil);
        }
        
    }];
    
    [weakEmeHttpRequest sendRequest:Resource.class loadingTip:NO errorTip:YES];
}

+ (void)queryResourceRequest:(QueryResourceRequest *)request withBlock:(NetApiResourceBlock)block {
    NetApiResourceBlock blk = [block copy];
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;
    
    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            NSArray* resourceArray = response;
            blk(@"success", resourceArray);
        }
        else {
            blk(@"fail", nil);
        }
        
    }];
    
    [weakEmeHttpRequest sendRequest:Resource.class loadingTip:YES errorTip:NO];
}

+ (void)deleteResourceRequestWithIdArray:(NSArray *)idLst withBlock:(NetApiResourceQueryBlock)block {
    NetApiResourceQueryBlock blk = [block copy];
    DeleteResourceRequest *request = [[DeleteResourceRequest alloc] init];
    request.idLst = idLst;
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;
    
    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"删除成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", nil);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];
    
    [weakEmeHttpRequest sendRequest:Resource.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)praiseResourceRequestWithId:(NSString *)Id withBlock:(NetApiResourceBlock)block {
    NetApiResourceBlock blk = [block copy];
    ResourcePraiseRequest *request = [[ResourcePraiseRequest alloc] init];
    request.id = Id;
    request.uId = [AppCacheManager sharedManager].loginUserId;
    
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;
    
    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"谢谢您的支持" andHideAfter:1 timeoutBlock:^{
                blk(@"success", nil);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];
    
    [weakEmeHttpRequest sendRequest:Priase.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)queryPraiseRequestWithId:(NSString *)Id withBlock:(NetApiResourceBlock)block {
    NetApiResourceBlock blk = [block copy];
    QueryPraiseRequest *request = [[QueryPraiseRequest alloc] init];
    request.id = Id;
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;
    
    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            NSArray *resourceArray = response;
            blk(@"success", resourceArray);
        }
        else {
            blk(@"fail", nil);
        }
    }];
    
    [weakEmeHttpRequest sendRequest:Priase.class loadingTip:YES errorTip:YES];
}

+ (void)commentResourceRequest:(ResourceCommentRequest *)request withBlock:(NetApiResourceBlock)block {
    NetApiResourceBlock blk = [block copy];
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;
    
    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"评论成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", nil);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];
    
    [weakEmeHttpRequest sendRequest:CommentDetail.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)queryCommentRequestWithId:(NSString *)Id withBlock:(NetApiCommentsBlock)block {
    NetApiCommentsBlock blk = [block copy];
    QueryCommentRequest *request = [[QueryCommentRequest alloc] init];
    request.id = Id;
    
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
    
    [weakEmeHttpRequest sendRequest:CommentDetail.class loadingTip:NO errorTip:YES];
}

@end
