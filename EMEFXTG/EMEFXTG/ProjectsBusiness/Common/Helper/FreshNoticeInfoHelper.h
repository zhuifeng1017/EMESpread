//
//  FreshNoticeInfoHelper.h
//  EMESHT
//
//  Created by appeme on 14/12/24.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatGroupNewInfoEntity.h"
#import "AppMessageManager.h"

@interface FreshNoticeInfoHelper : NSObject
+ (ChatGroupNewInfoEntity *)getChatGroupInfoEntity:(AppMessage *)appMessage;
+ (void)deleteChatGroupNewInfoEntity:(NSString *)groupId;
+ (int)countOfNewChat;

@end
