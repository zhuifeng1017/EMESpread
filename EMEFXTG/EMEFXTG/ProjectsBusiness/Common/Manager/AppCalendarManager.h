//
//  AppCalendarManager.h
//  EMEZL
//
//  Created by appeme on 15/4/24.
//  Copyright (c) 2015年 appeme. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Calendar;

@interface AppCalendarManager : NSObject
@property (strong, nonatomic) NSArray *calendars;
+ (Calendar *)findCalendarById:(NSString *)id;
+ (instancetype)sharedManager;
- (void)queryCalendar;
@end
