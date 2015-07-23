//
//  NetApiSocialGroupHelper.h
//  EMESHT
//
//  Created by appeme on 15/3/5.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocialGroup.h"

typedef void (^NetApiSocialGroupBlock)(NSString *message, SocialGroup *group);
typedef void (^NetApiSocialGroupArrayBlock)(NSString *message, NSArray *groupArray);
typedef void (^NetApiSocialGroupAnnounceBlock)(NSString *message, SocialGroupAnnounce *group);

@interface NetApiSocialGroupHelper : NSObject
+ (void)sendSaveRequest:(NSString *)title content:(NSString *)content userId:(NSString *)uId withBlock:(NetApiSocialGroupBlock)block;
+ (void)sendUpdateRequest:(NSString *)socialId title:(NSString *)title withBlock:(NetApiSocialGroupBlock)block;
+ (void)sendQueryRequest:(NSString *)title block:(NetApiSocialGroupArrayBlock)block;
+ (void)sendApplyRequest:(NSString *)socialId userId:(NSString *)uId forSocialGroupName:(NSString *)groupName withBlock:(NetApiSocialGroupBlock)block;
+ (void)sendInviteRequest:(NSString *)socialId userIdLst:(NSArray *)uIdLst fromFriendId:(NSString *)fId withBlock:(NetApiSocialGroupBlock)block;
+ (void)sendPassApplyRequest:(NSString *)socialId userId:(NSString *)uId withBlock:(NetApiSocialGroupBlock)block;
+ (void)sendPassInviteRequest:(NSString *)socialId userId:(NSString *)uId withBlock:(NetApiSocialGroupBlock)block;
+ (void)sendRefuseApplyRequest:(NSString *)socialId userId:(NSString *)uId withBlock:(NetApiSocialGroupBlock)block;
+ (void)sendRefuseInviteRequest:(NSString *)socialId userId:(NSString *)uId withBlock:(NetApiSocialGroupBlock)block;
+ (void)sendAdminRequest:(NSString *)socialId userId:(NSArray *)uIdLst withBlock:(NetApiSocialGroupBlock)block;
+ (void)sendGetApplyRequest:(NSString *)socialId userId:(NSString *)uId withBlock:(NetApiSocialGroupArrayBlock)block;
+ (void)sendGetInviteRequest:(NSString *)userId withBlock:(NetApiSocialGroupArrayBlock)block;
+ (void)sendGetMemberRequest:(NSString *)socialId withBlock:(NetApiSocialGroupArrayBlock)block;
+ (void)sendMyRequest:(NSString *)uId withBlock:(NetApiSocialGroupArrayBlock)block;
+ (void)sendExitRequest:(NSString *)socialId userId:(NSString *)uId withBlock:(NetApiSocialGroupBlock)block;
+ (void)sendDeleteMemberRequest:(NSString *)socialId userIdLst:(NSArray *)uIdLst withBlock:(NetApiSocialGroupArrayBlock)block;

#pragma mark--  Announce
+ (void)sendSaveAnnounceRequest:(SaveSocialGroupAnnounceRequest *)request withBlock:(NetApiSocialGroupAnnounceBlock)block;
+ (void)sendUpdateAnnounceRequest:(UpdateSocialGroupAnnounceRequest *)request withBlock:(NetApiSocialGroupAnnounceBlock)block;

+ (void)sendAnnounceQueryRequest:(NSString *)socialId withBlock:(NetApiSocialGroupArrayBlock)block;

+ (void)sendDeleteAnnounceRequest:(NSString *)userId idLst:(NSArray *)idLst withBlock:(NetApiSocialGroupArrayBlock)block;

@end
