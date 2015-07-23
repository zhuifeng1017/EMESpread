//
//  NetApiUserHelper.m
//  EMESHT
//
//  Created by xuanhr on 15/1/21.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "NetApiUserHelper.h"
@interface NetApiUserHelper ()
@end

@implementation NetApiUserHelper

+ (void)updataPassword:(UpdatePasswordRequest *)request withBlock:(NetApiUserBlock)block {
    NetApiUserBlock blk = [block copy];
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"修改密码成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", nil);
            }];
        }
        else {
            blk(@"fail", nil);
        }

    }];

    [weakEmeHttpRequest sendRequest:LooseJSONModel.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)completeUserInfo:(CompleteInfoRequest *)request withBlock:(NetApiUserBlock)block {
    NetApiUserBlock blk = [block copy];
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            Login *login = response;
            [weakEmeHttpRequest setProgressMessage:@"完善资料成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", login);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:Login.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)updataUserInfo:(UpdateInfoRequest *)request withBlock:(NetApiUserBlock)block {
    NetApiUserBlock blk = [block copy];
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            Login *login = response;
            [weakEmeHttpRequest setProgressMessage:@"修改成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", login);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:Login.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

@end
