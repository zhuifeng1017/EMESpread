//
//  NetApiResourceHelper.h
//  EMESHT
//
//  Created by xuanhr on 15/2/2.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Resource.h"

typedef void (^NetApiResourceBlock)(NSString *message,  NSArray*resourceArray);
typedef void (^NetApiCommentsBlock)(NSString *message,  NSArray *comments);
typedef void (^NetApiResourceQueryBlock)(NSString *message, NSArray *idLst);

@interface NetApiResourceHelper : NSObject
+ (void)saveResourceRequest:(SaveResourceRequest *)request withBlock:(NetApiResourceBlock)block;
+ (void)updateResourceRequest:(UpdateResourceRequest *)request withBlock:(NetApiResourceBlock)block;
+ (void)queryResourceRequest:(QueryResourceRequest *)request withBlock:(NetApiResourceBlock)block;
+ (void)deleteResourceRequestWithIdArray:(NSArray *)idLst withBlock:(NetApiResourceQueryBlock)block;
///praise
+ (void)praiseResourceRequestWithId:(NSString *)Id withBlock:(NetApiResourceBlock)block;
+ (void)queryPraiseRequestWithId:(NSString *)Id withBlock:(NetApiResourceBlock)block;
+ (void)commentResourceRequest:(ResourceCommentRequest *)request withBlock:(NetApiResourceBlock)block;
+ (void)queryCommentRequestWithId:(NSString *)Id withBlock:(NetApiCommentsBlock)block;

@end
