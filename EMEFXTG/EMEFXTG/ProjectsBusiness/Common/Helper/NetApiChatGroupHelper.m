//
//  ChatGroupHelper.m
//  EMESHT
//
//  Created by appeme on 14-12-1.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "NetApiChatGroupHelper.h"

@interface NetApiChatGroupHelper ()
@property (copy, nonatomic) ChatGroupBlock createNewGroupBlock;
@property (copy, nonatomic) ChatGroupBlock updateGroupNameBlock;
@property (copy, nonatomic) ChatGroupBlock getGroupBlock;
@property (copy, nonatomic) ChatGroupBlock addMemeberBlock;
@property (copy, nonatomic) ChatGroupBlock deleteMemberBlock;
@property (strong, nonatomic) EMEHttpRequest *emeHttpRequest;
@end

@implementation NetApiChatGroupHelper
+ (void)createNewChatGroup:(NSArray *)membersArray withBlock:(ChatGroupBlock)block {
    ChatGroupBlock blk = [block copy];

    SaveGroupRequest *request = [[SaveGroupRequest alloc] init];
    request.uId = [AppCacheManager sharedManager].loginUserId;
    request.memberIdLst = membersArray;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            UserGroup *group = response;
            //        [weakEmeHttpRequest setProgressMessage:@"创建了新群组" andHideAfter:1 timeoutBlock:^{
            blk(@"success", group);
            //        }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:UserGroup.class loadingTip:YES errorTip:YES];
}

+ (void)updateChatGroupName:(NSString *)groupName ById:(NSString *)groupId withBlock:(ChatGroupBlock)block {
    ChatGroupBlock blk = [block copy];

    UpdateUserGroup *request = [[UpdateUserGroup alloc] init];
    request.id = groupId;
    request.title = groupName;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            UserGroup *group = response;
            [weakEmeHttpRequest setProgressMessage:@"修改成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", group);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:UserGroup.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)getChatGroupById:(NSString *)groupId withBlock:(ChatGroupBlock)block {
    ChatGroupBlock blk = [block copy];

    GetGroupRequest *request = [[GetGroupRequest alloc] init];
    request.id = groupId;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            UserGroup *group = response;
            blk(@"success", group);
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:UserGroup.class loadingTip:NO errorTip:YES];
}

+ (void)addMembers:(NSArray *)membersArray withGroupId:(NSString *)groupId withBlock:(ChatGroupBlock)block {
    ChatGroupBlock blk = [block copy];

    AddMemberGroupRequest *request = [[AddMemberGroupRequest alloc] init];
    request.id = groupId;
    request.memberIdLst = membersArray;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            UserGroup *group = response;
            [weakEmeHttpRequest setProgressMessage:@"添加了新成员" andHideAfter:1 timeoutBlock:^{
                blk(@"success", group);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:UserGroup.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)addMembersQuiesce:(NSArray *)membersArray withGroupId:(NSString *)groupId withBlock:(ChatGroupBlock)block {
    ChatGroupBlock blk = [block copy];

    AddMemberGroupRequest *request = [[AddMemberGroupRequest alloc] init];
    request.id = groupId;
    request.memberIdLst = membersArray;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;
    
    [weakEmeHttpRequest sendRequest:UserGroup.class loadingTip:NO autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)deleteMembers:(NSArray *)membersArray withGroupId:(NSString *)groupId withBlock:(ChatGroupBlock)block {
    ChatGroupBlock blk = [block copy];

    DeleteMemberGroupRequest *request = [[DeleteMemberGroupRequest alloc] init];
    request.id = groupId;
    request.memberIdLst = membersArray;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            UserGroup *group = response;
            [weakEmeHttpRequest setProgressMessage:@"删除了成员" andHideAfter:1 timeoutBlock:^{
                blk(@"success", group);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:UserGroup.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

@end
