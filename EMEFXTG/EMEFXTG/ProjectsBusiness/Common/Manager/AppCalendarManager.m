//
//  AppCalendarManager.m
//  EMEZL
//
//  Created by appeme on 15/4/24.
//  Copyright (c) 2015年 appeme. All rights reserved.
//

#import "AppCalendarManager.h"
#import "NetApiCalendarHelper.h"
#import "EMEHttpBatchRequest.h"
#import "Calendar.h"

@interface AppCalendarManager ()
@property (strong, nonatomic) EMEHttpBatchRequest *emeHttpBatchRequest;
@property (copy, nonatomic) NSNumber *lastCalendarLoggerDownloadTimeL;
@property (assign, nonatomic) long long maxLastCalendarLoggerDownloadTimeL;
@end

@implementation AppCalendarManager
+ (instancetype)sharedManager {
    static AppCalendarManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AppCalendarManager alloc] init];
        instance.maxLastCalendarLoggerDownloadTimeL = -1;
        
    });
    
    return instance;
}

+ (Calendar *)findCalendarById:(NSString *)id {
    NSArray *calendars = [AppCalendarManager sharedManager].calendars;
    for (int i = 0; i < calendars.count; i++) {
        Calendar *calendar = calendars[i];
        
        if ([id isEqualToString:calendar.id]) {
            return calendar;
        }
    }
    
    return nil;
}

- (void)queryCalendar {
    QueryCalendarRequest *request = [[QueryCalendarRequest alloc] init];
    request.uId = [AppCacheManager sharedManager].loginUserId;
    request.lastTime = @"0";
    
    WEAKSELF;
    _emeHttpBatchRequest = [[EMEHttpBatchRequest alloc] initWithRequest:request];
    [_emeHttpBatchRequest setBatchCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            weakSelf.calendars = response;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NoticeCalendarTableRefresh object:nil];
        }
    }];
    [_emeHttpBatchRequest sendRequest:request response:Calendar.class loadingTip:NO autoHideLoadingTipAfterCompletion:NO errorTip:NO];

}
@end

