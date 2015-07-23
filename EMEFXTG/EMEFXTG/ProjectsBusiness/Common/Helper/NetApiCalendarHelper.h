//
//  CalendarHelper.h
//  EMESHT
//
//  Created by xuanhr on 14-12-2.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calendar.h"
#import "NetApiHelper.h"

typedef void (^CalendarBlock)(NSString *message, Calendar *calendar);

@interface NetApiCalendarHelper : NSObject

+ (void)saveCalendar:(SaveCalendarRequest *)request withBlock:(CalendarBlock)block;
+ (void)updateCalendar:(UpdateCalendarRequest *)request withBlock:(CalendarBlock)block;
+ (void)deleteCalendarWithCalendarId:(NSString *)theId andTag:(NSString *)tag withBlock:(CalendarBlock)block;
+ (void)queryCalendarWithTime:(NSString *)lastTime withBlock:(NetApiArrayBlock)block;

+ (void)addMemberInviteCalendarWithMember:(NSArray *)memberLst andCalendarId:(NSString *)calendarId withBlock:(CalendarBlock)block;
+ (void)leaveCalendarWithCalendarId:(NSString *)calendarId withBlock:(CalendarBlock)block;

@end
