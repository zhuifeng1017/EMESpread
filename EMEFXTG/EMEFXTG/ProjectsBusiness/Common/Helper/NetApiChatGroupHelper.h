//
//  ChatGroupHelper.h
//  EMESHT
//
//  Created by appeme on 14-12-1.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserGroup.h"

typedef void (^ChatGroupBlock)(NSString *message, UserGroup *userGroup);

@interface NetApiChatGroupHelper : NSObject
//membersArray: AddressBookInfo[]
+ (void)createNewChatGroup:(NSArray *)membersArray withBlock:(ChatGroupBlock)block;
+ (void)updateChatGroupName:(NSString *)groupName ById:(NSString *)groupId withBlock:(ChatGroupBlock)block;
+ (void)getChatGroupById:(NSString *)groupId withBlock:(ChatGroupBlock)block;
+ (void)addMembers:(NSArray *)membersArray withGroupId:(NSString *)groupId withBlock:(ChatGroupBlock)block;
+ (void)addMembersQuiesce:(NSArray *)membersArray withGroupId:(NSString *)groupId withBlock:(ChatGroupBlock)block;
+ (void)deleteMembers:(NSArray *)membersArray withGroupId:(NSString *)groupId withBlock:(ChatGroupBlock)block;
@end
