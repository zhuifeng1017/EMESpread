//
//  NetApiCrowdFundingHelper.m
//  EMESHT
//
//  Created by xuanhr on 15/1/22.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "NetApiCrowdFundingHelper.h"
#import "EMEHttpRequest.h"

@interface NetApiCrowdFundingHelper ()
@end

@implementation NetApiCrowdFundingHelper
+ (void)saveCrowdFundingRequest:(SaveCrowdFundingRequest *)request withBlock:(NetApiCrowdFundingBlock)block {
    NetApiCrowdFundingBlock blk = [block copy];
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            CrowdFunding *crowdFunding = response;
            [weakEmeHttpRequest setProgressMessage:@"保存成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", crowdFunding);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:CrowdFunding.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)updateCrowdFundingRequest:(UpdateCrowdFundingRequest *)request withBlock:(NetApiCrowdFundingBlock)block {
    NetApiCrowdFundingBlock blk = [block copy];
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            CrowdFunding *crowdFunding = response;
            [weakEmeHttpRequest setProgressMessage:@"更新成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", crowdFunding);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:CrowdFunding.class loadingTip:YES errorTip:YES];
}

+ (void)queryCrowdFundingRequest:(QueryCrowdFundingRequest *)request withBlock:(NetApiCrowdFundingQueryBlock)block {
    NetApiCrowdFundingBlock blk = [block copy];
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

    [weakEmeHttpRequest sendRequest:CrowdFunding.class loadingTip:YES errorTip:YES];
}

+ (void)deleteCrowdFundingRequestWithIdArray:(NSArray *)idLst withBlock:(NetApiCrowdFundingQueryBlock)block {
    NetApiCrowdFundingBlock blk = [block copy];
    DeleteCrowdFundingRequest *request = [[DeleteCrowdFundingRequest alloc] init];
    request.idLst = idLst;
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"删除成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", response);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:CrowdFunding.class loadingTip:YES errorTip:YES];
}

@end
