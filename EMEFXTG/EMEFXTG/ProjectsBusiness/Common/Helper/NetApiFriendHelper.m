//
//  FriendHelper.m
//  EMESHT
//
//  Created by xuanhr on 14/12/18.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "NetApiFriendHelper.h"
#import "User.h"
@interface NetApiFriendHelper ()
@end

@implementation NetApiFriendHelper

+ (void)addFriendWithFriendId:(NSString *)friendId withBlock:(AddFriendBlock)block {
    AddFriendBlock blk = [block copy];

    SaveFriendRequest *saveFriendRequest = [[SaveFriendRequest alloc] init];
    saveFriendRequest.uId = [AppCacheManager sharedManager].loginUserId;
    saveFriendRequest.fId = friendId;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:saveFriendRequest];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
//            [weakEmeHttpRequest setProgressMessage:@"添加好友成功" andHideAfter:1 timeoutBlock:^{
//                
//            }];
            blk(@"success");
        }
        else {
            blk(@"fail");
        }

    }];

    [weakEmeHttpRequest sendRequest:Login.class loadingTip:YES autoHideLoadingTipAfterCompletion:YES errorTip:YES];
}

//- (void)passFriendWithFriendId:(NSString *)friendId andMessageId:(NSString *)megId withBlock:(AddFriendBlock)block {
//    self.passFriendBlock = block;
//
//    PassFriendRequest *request = [[PassFriendRequest alloc] init];
//    request.uId = friendId;
//    request.fId = [AppCacheManager sharedManager].loginUserId;
//    request.mId = megId;
//
//    _emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
//    WEAKSELF
//
//    [_emeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
//        [weakSelf.emeHttpRequest setProgressMessage:@"添加成功" andHideAfter:1 timeoutBlock:^{
//
//        }];
//        weakSelf.passFriendBlock(@"success");
//    }];
//    [_emeHttpRequest setFailedBlock:^(NSError *error) {
//        weakSelf.passFriendBlock(@"fail");
//    }];
//
//    [_emeHttpRequest sendRequest:User.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
//}
//
//- (void)refuseFriendWithFriendId:(NSString *)friendId andMessageId:(NSString *)megId withBlock:(AddFriendBlock)block {
//    self.refuseFriendBlock = block;
//
//    RefuseFriendRequest *request = [[RefuseFriendRequest alloc] init];
//    request.uId = friendId;
//    request.fId = [AppCacheManager sharedManager].loginUserId;
//    request.mId = megId;
//
//    _emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
//    WEAKSELF
//
//    [_emeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
//        [weakSelf.emeHttpRequest setProgressMessage:@"拒绝成功" andHideAfter:1 timeoutBlock:^{
//
//        }];
//        weakSelf.refuseFriendBlock(@"success");
//    }];
//    [_emeHttpRequest setFailedBlock:^(NSError *error) {
//        weakSelf.refuseFriendBlock(@"fail");
//    }];
//
//    [_emeHttpRequest sendRequest:User.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
//}

+ (void)getFriendWithUId:(NSString *)uId withBlock:(GetFriendBlock)block {
    GetFriendBlock blk = [block copy];

    GetFriendRequest *request = [[GetFriendRequest alloc] init];
    request.uId = uId;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            MyFriend *myfriend = response;
            blk(@"success",myfriend.friendLst);
        }
        else {
            blk(@"fail",nil);
        }

    }];

    [weakEmeHttpRequest sendRequest:MyFriend.class loadingTip:YES errorTip:YES];
}

+ (void)deleteFriendWithFId:(NSString *)fId withBlock:(GetFriendBlock)block {
    GetFriendBlock blk = [block copy];

    DeleteFriendRequest *request = [[DeleteFriendRequest alloc] init];
    request.uId = [AppCacheManager sharedManager].loginUserId;
    request.fIdLst = @[fId];

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            MyFriend *myfriend = (MyFriend*)response;
            blk(@"success",myfriend.friendLst);
        }
        else {
            blk(@"fail",nil);
        }

    }];

    [weakEmeHttpRequest sendRequest:MyFriend.class loadingTip:YES errorTip:YES];
}
@end
