//
//  BaseHelper.m
//  EMESHT
//
//  Created by xuanhr on 15/1/20.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "NetApiBaseHelper.h"
#import "EMEHttpRequest.h"

@interface NetApiBaseHelper ()
@end

@implementation NetApiBaseHelper
+ (void)sendRegister:(RegisterRequest *)request withBlock:(NetApiBaseBlock)block {
    NetApiBaseBlock blk = [block copy];
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            Login *login = response;
            [weakEmeHttpRequest setProgressMessage:@"注册成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", login);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:Login.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)sendLogin:(LoginRequest *)request withBlock:(NetApiBaseBlock)block {
    NetApiBaseBlock blk = [block copy];
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [emeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
         if (status == EMEHttpRequestStatusSuccess) {
             Login *login = response;
             [weakEmeHttpRequest setProgressMessage:@"登录成功" andHideAfter:0.5 timeoutBlock:^{
                 blk(@"success", login);
             }];
         }
         else {
             [weakEmeHttpRequest hideProgress];//少数情况下需要hide
             blk(@"fail", nil);
         }
    }];

    [emeHttpRequest sendRequest:Login.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)sendLoginOutWithBlock:(NetApiBaseBlock)block {
    NetApiBaseBlock blk = [block copy];
    LoginOutRequest *request = [[LoginOutRequest alloc] init];
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"退出成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", nil);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:LooseJSONModel.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)sendCheckVersion:(CheckVersionRequest *)request withBlock:(NetApiBaseVersionBlock)block {
    NetApiBaseVersionBlock blk = [block copy];
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            Version *version = response;
            blk(@"success", version);
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:Version.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}
@end
