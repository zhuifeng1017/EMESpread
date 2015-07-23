//
//  EMEHttpBatchRequest.m
//  EMESHT
//
//  Created by appeme on 15/2/10.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "EMEHttpBatchRequest.h"

@interface EMEHttpBatchRequest ()
@property (strong, nonatomic) EMEHttpRequest *emeHttpRequest;
@property (assign, nonatomic) int pageIndex;
@property (copy, nonatomic) EMEHttpRequestCompletionBlock batchCompletionBlock; //block to execute when requests complete
@end

@implementation EMEHttpBatchRequest
- (void)sendRequest:(LooseJSONModel *)request response:(Class)responseClass loadingTip:(BOOL)loadingTip autoHideLoadingTipAfterCompletion:(BOOL)autoHide errorTip:(BOOL)errorTip {

    request.pageSize = @(100);
    request.offset = @(self.batchResponse.count);

    WEAKSELF

    _emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    [_emeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            if (!weakSelf.batchResponse) {
                weakSelf.batchResponse = [NSMutableArray array];
            }
            [weakSelf.batchResponse addObjectsFromArray:(NSArray *)response];
            
            // send request
            if (hasNext) {
                [weakSelf sendRequest:request response:responseClass loadingTip:loadingTip autoHideLoadingTipAfterCompletion:autoHide errorTip:errorTip];
            }
            else if (weakSelf.batchCompletionBlock) {
                weakSelf.batchCompletionBlock(EMEHttpRequestStatusSuccess, nil, weakSelf.batchResponse, YES, NO);
            }
        }
        else {
            weakSelf.batchCompletionBlock(EMEHttpRequestStatusError, nil, weakSelf.batchResponse, YES, NO);
        }
    }];

    [_emeHttpRequest sendRequest:responseClass loadingTip:loadingTip autoHideLoadingTipAfterCompletion:autoHide errorTip:errorTip];
}

- (void)setBatchCompletionBlock:(EMEHttpRequestCompletionBlock)aCompletionBlock {
    _batchCompletionBlock = [aCompletionBlock copy];
}

@end
