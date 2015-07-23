//
//  NetApiSocialGroupHelper.m
//  EMESHT
//
//  Created by appeme on 15/3/5.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "NetApiSocialGroupHelper.h"

@implementation NetApiSocialGroupHelper
+ (void)sendSaveRequest:(NSString *)title content:(NSString *)content userId:(NSString *)uId withBlock:(NetApiSocialGroupBlock)block {
    NetApiSocialGroupBlock blk = [block copy];
    SaveSocialGroupRequest *request = [[SaveSocialGroupRequest alloc] init];
    request.title = title;
    request.content = content;
    request.uId = uId;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"保存成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", response);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:SocialGroup.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)sendUpdateRequest:(NSString *)socialId title:(NSString *)title withBlock:(NetApiSocialGroupBlock)block {
    NetApiSocialGroupBlock blk = [block copy];
    UpdateSocialGroupRequest *request = [[UpdateSocialGroupRequest alloc] init];
    request.id = socialId;
    request.title = title;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"修改成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", response);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:SocialGroup.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)sendQueryRequest:(NSString *)title block:(NetApiSocialGroupArrayBlock)block {
    NetApiSocialGroupArrayBlock blk = [block copy];
    QuerySocialGroupRequest *request = [[QuerySocialGroupRequest alloc] init];
    request.title = title;
    request.pageSize = @500;

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

    [weakEmeHttpRequest sendRequest:SocialGroup.class loadingTip:YES errorTip:YES];
}

+ (void)sendApplyRequest:(NSString *)socialId userId:(NSString *)uId forSocialGroupName:(NSString *)groupName withBlock:(NetApiSocialGroupBlock)block {
    NetApiSocialGroupBlock blk = [block copy];
    ApplySocialGroupRequest *request = [[ApplySocialGroupRequest alloc] init];
    request.id = socialId;
    request.uId = uId;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:[NSString stringWithFormat:@"已申请加入圈子'%@'", groupName] andHideAfter:1 timeoutBlock:^{
                blk(@"success", response);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:SocialGroup.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)sendInviteRequest:(NSString *)socialId userIdLst:(NSArray *)uIdLst fromFriendId:(NSString *)fId withBlock:(NetApiSocialGroupBlock)block {
    NetApiSocialGroupBlock blk = [block copy];
    InviteSocialGroupRequest *request = [[InviteSocialGroupRequest alloc] init];
    request.id = socialId;
    request.fId = fId;
    request.uIdLst = uIdLst;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"已发送邀请" andHideAfter:1 timeoutBlock:^{
                blk(@"success", response);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:SocialGroup.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)sendPassApplyRequest:(NSString *)socialId userId:(NSString *)uId withBlock:(NetApiSocialGroupBlock)block {
    NetApiSocialGroupBlock blk = [block copy];
    PassApplySocialGroupRequest *request = [[PassApplySocialGroupRequest alloc] init];
    request.id = socialId;
    request.uId = uId;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"已发送邀请" andHideAfter:1 timeoutBlock:^{
                blk(@"success", response);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:SocialGroup.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)sendPassInviteRequest:(NSString *)socialId userId:(NSString *)uId withBlock:(NetApiSocialGroupBlock)block {
    NetApiSocialGroupBlock blk = [block copy];
    PassInviteSocialGroupRequest *request = [[PassInviteSocialGroupRequest alloc] init];
    request.id = socialId;
    request.uId = uId;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"已发送邀请" andHideAfter:1 timeoutBlock:^{
                blk(@"success", response);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:SocialGroup.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)sendRefuseApplyRequest:(NSString *)socialId userId:(NSString *)uId withBlock:(NetApiSocialGroupBlock)block {
    NetApiSocialGroupBlock blk = [block copy];
    RefuseApplySocialGroupRequest *request = [[RefuseApplySocialGroupRequest alloc] init];
    request.id = socialId;
    request.uId = uId;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"已发送邀请" andHideAfter:1 timeoutBlock:^{
                blk(@"success", response);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:SocialGroup.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)sendRefuseInviteRequest:(NSString *)socialId userId:(NSString *)uId withBlock:(NetApiSocialGroupBlock)block {
    NetApiSocialGroupBlock blk = [block copy];
    RefuseInviteSocialGroupRequest *request = [[RefuseInviteSocialGroupRequest alloc] init];
    request.id = socialId;
    request.uId = uId;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"已发送邀请" andHideAfter:1 timeoutBlock:^{
                blk(@"success", response);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:SocialGroup.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)sendAdminRequest:(NSString *)socialId userId:(NSArray *)uIdLst withBlock:(NetApiSocialGroupBlock)block {
    NetApiSocialGroupBlock blk = [block copy];
    AdminSocialGroupRequest *request = [[AdminSocialGroupRequest alloc] init];
    request.id = socialId;
    request.uIdLst = uIdLst;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"设置管理员成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", response);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:SocialGroup.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)sendGetApplyRequest:(NSString *)socialId userId:(NSString *)uId withBlock:(NetApiSocialGroupArrayBlock)block {
    NetApiSocialGroupArrayBlock blk = [block copy];
    GetApplySocialGroupRequest *request = [[GetApplySocialGroupRequest alloc] init];
    request.id = socialId;
    request.uId = uId;

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

    [weakEmeHttpRequest sendRequest:User.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)sendGetInviteRequest:(NSString *)userId withBlock:(NetApiSocialGroupArrayBlock)block {
    NetApiSocialGroupArrayBlock blk = [block copy];
    GetInviteSocialGroupRequest *request = [[GetInviteSocialGroupRequest alloc] init];
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

    [weakEmeHttpRequest sendRequest:GetSocialGroupInviteResponse.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)sendGetMemberRequest:(NSString *)socialId withBlock:(NetApiSocialGroupArrayBlock)block {
    NetApiSocialGroupArrayBlock blk = [block copy];
    GetMemberSocialGroupRequest *request = [[GetMemberSocialGroupRequest alloc] init];
    request.id = socialId;

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

    [weakEmeHttpRequest sendRequest:SocialGroupMember.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)sendMyRequest:(NSString *)uId withBlock:(NetApiSocialGroupArrayBlock)block {
    NetApiSocialGroupArrayBlock blk = [block copy];
    MySocialGroupRequest *request = [[MySocialGroupRequest alloc] init];
    request.uId = uId;

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

    [weakEmeHttpRequest sendRequest:SocialGroup.class loadingTip:YES errorTip:YES];
}

+ (void)sendExitRequest:(NSString *)socialId userId:(NSString *)uId withBlock:(NetApiSocialGroupBlock)block {
    NetApiSocialGroupArrayBlock blk = [block copy];
    ExitSocialGroupRequest *request = [[ExitSocialGroupRequest alloc] init];
    request.id = socialId;
    request.uId = uId;

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

    [weakEmeHttpRequest sendRequest:SocialGroup.class loadingTip:YES errorTip:YES];
}

+ (void)sendDeleteMemberRequest:(NSString *)socialId userIdLst:(NSArray *)uIdLst withBlock:(NetApiSocialGroupArrayBlock)block {
    NetApiSocialGroupArrayBlock blk = [block copy];
    DeleteMemberSocialGroupRequest *request = [[DeleteMemberSocialGroupRequest alloc] init];
    request.id = socialId;
    request.uIdLst = uIdLst;

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

    [weakEmeHttpRequest sendRequest:User.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

#pragma mark--  Announce

+ (void)sendSaveAnnounceRequest:(SaveSocialGroupAnnounceRequest *)request withBlock:(NetApiSocialGroupAnnounceBlock)block {
    NetApiSocialGroupArrayBlock blk = [block copy];

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"创建成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", response);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:SocialGroupAnnounce.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)sendUpdateAnnounceRequest:(UpdateSocialGroupAnnounceRequest *)request withBlock:(NetApiSocialGroupAnnounceBlock)block {
    NetApiSocialGroupArrayBlock blk = [block copy];

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            [weakEmeHttpRequest setProgressMessage:@"修改成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", response);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:SocialGroupAnnounce.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)sendAnnounceQueryRequest:(NSString *)socialId withBlock:(NetApiSocialGroupArrayBlock)block {
    NetApiSocialGroupArrayBlock blk = [block copy];
    QuerySocialGroupAnnounceRequest *request = [[QuerySocialGroupAnnounceRequest alloc] init];
    request.gId = socialId;

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

    [weakEmeHttpRequest sendRequest:SocialGroupAnnounce.class loadingTip:YES errorTip:YES];
}

+ (void)sendDeleteAnnounceRequest:(NSString *)userId idLst:(NSArray *)idLst withBlock:(NetApiSocialGroupArrayBlock)block {
}

@end
