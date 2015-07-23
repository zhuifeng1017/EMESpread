//
//  CalendarHelper.m
//  EMESHT
//
//  Created by xuanhr on 14-12-2.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "NetApiCalendarHelper.h"
#import "EMEHttpRequest.h"

@interface NetApiCalendarHelper ()
@end

@implementation NetApiCalendarHelper

+ (void)saveCalendar:(SaveCalendarRequest *)request withBlock:(CalendarBlock)block {
    CalendarBlock blk = [block copy];
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            Calendar *calendar = response;
            [weakEmeHttpRequest setProgressMessage:@"保存成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", calendar);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:Calendar.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)updateCalendar:(UpdateCalendarRequest *)request withBlock:(CalendarBlock)block {
    CalendarBlock blk = [block copy];

    request.uId = [AppCacheManager sharedManager].loginUserId;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            Calendar *calendar = response;
            blk(@"success", calendar);
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:Calendar.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)deleteCalendarWithCalendarId:(NSString *)theId andTag:(NSString *)tag withBlock:(CalendarBlock)block {
    CalendarBlock blk = [block copy];
    DeleteCalendarRequest *request = [[DeleteCalendarRequest alloc] init];
    request.uId = [AppCacheManager sharedManager].loginUserId;
    request.id = theId;
    request.tag = tag;
    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            Calendar *calendar = response;
            [weakEmeHttpRequest setProgressMessage:@"删除成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", calendar);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:Calendar.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)queryCalendarWithTime:(NSString *)lastTime withBlock:(NetApiArrayBlock)block {
    CalendarBlock blk = [block copy];
    QueryCalendarRequest *request = [[QueryCalendarRequest alloc] init];
    request.uId = [AppCacheManager sharedManager].loginUserId;
    request.lastTime = lastTime;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            Calendar *calendar = response;
            blk(@"success", calendar);
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:Calendar.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)addMemberInviteCalendarWithMember:(NSArray *)memberLst andCalendarId:(NSString *)calendarId withBlock:(CalendarBlock)block {
    CalendarBlock blk = [block copy];
    AddMemberInviteCalendarRequest *request = [[AddMemberInviteCalendarRequest alloc] init];
    request.uId = [AppCacheManager sharedManager].loginUserId;
    request.id = calendarId;
    request.memberLst = memberLst;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            Calendar *calendar = response;
            [weakEmeHttpRequest setProgressMessage:@"添加成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", calendar);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:Calendar.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

+ (void)leaveCalendarWithCalendarId:(NSString *)calendarId withBlock:(CalendarBlock)block {
    CalendarBlock blk = [block copy];
    DelMemberInviteCalendarRequest *request = [[DelMemberInviteCalendarRequest alloc] init];
    request.uId = [AppCacheManager sharedManager].loginUserId;
    request.id = calendarId;

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            Calendar *calendar = response;
            [weakEmeHttpRequest setProgressMessage:@"离开成功" andHideAfter:1 timeoutBlock:^{
                blk(@"success", calendar);
            }];
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:Calendar.class loadingTip:YES autoHideLoadingTipAfterCompletion:NO errorTip:YES];
}

@end
