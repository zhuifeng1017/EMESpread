//
//  FreshNoticeInfoHelper.m
//  EMESHT
//
//  Created by appeme on 14/12/24.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "FreshNoticeInfoHelper.h"
#import "EMEDatabaseManager.h"

@implementation FreshNoticeInfoHelper
+ (ChatGroupNewInfoEntity *)getChatGroupInfoEntity:(AppMessage *)appMessage {
    ChatGroupNewInfoEntity *readChatGroupNewInfoEntity;
    NSString *condition = [NSString stringWithFormat:@"id = '%@' and uId = '%@' and type = 'chat'", appMessage.chat.group.id, [AppCacheManager sharedManager].loginUserId];
    
    readChatGroupNewInfoEntity = (ChatGroupNewInfoEntity *)[[[EMEDatabaseManager sharedInstance].chatGroupNewInfoDatabase selectAll:condition] firstObject];
    return readChatGroupNewInfoEntity;
}

+ (void)deleteChatGroupNewInfoEntity:(NSString *)groupId {
    NSString *condition = [NSString stringWithFormat:@"id = '%@' and uId = '%@' and type = 'chat'", groupId, [AppCacheManager sharedManager].loginUserId];
    [[EMEDatabaseManager sharedInstance].chatGroupNewInfoDatabase deleteAll:condition];
}

+ (int)countOfNewChat {
    NSString *condition = [NSString stringWithFormat:@"uId = '%@' and type = 'chat'", [AppCacheManager sharedManager].loginUserId];
    NSArray *groups = [[EMEDatabaseManager sharedInstance].chatGroupNewInfoDatabase selectAll:condition];
    
    int allCount = 0;
    for (int i = 0; i < groups.count; i++) {
        ChatGroupNewInfoEntity *entity = groups[i];
        allCount += [entity.freshInfoCount integerValue];
    }
    return allCount;
}
@end
