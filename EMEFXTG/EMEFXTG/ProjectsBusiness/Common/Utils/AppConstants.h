//
//  AppConstants.h
//  EMESHT
//
//  Created by xuanhr on 14-11-26.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NoticeApplicationWillEnterForeground @"NoticeApplicationWillEnterForeground"
#define NoticeApplicationWillEnterBackground @"NoticeApplicationWillEnterBackground"

#define NoticeFavActivityChanged @"NoticeFavActivityChanged" // 收藏的活动有改变
#define NoticeMyActivityChanged @"NoticeMyActivityChanged"   // 参与的活动有改变

#define NoticeAllActivityChanged @"NoticeAllActivityChanged"
#define NoticeAllGnosisChanged @"NoticeAllGnosisChanged"
#define NoticeAllNwitChanged @"NoticeAllNwitChanged"

#define NoticeCalendarChanged @"NoticeCalendarChanged"
#define NoticeCalendarTableRefresh @"NoticeCalendarTableRefresh"

@interface AppConstants : NSObject
+ (NSDictionary *)getSmilieDictionary;
@end
