//
//  NetApiUserHelper.h
//  EMESHT
//
//  Created by xuanhr on 15/1/21.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Login.h"

typedef void (^NetApiUserBlock)(NSString *message, Login *login);


@interface NetApiUserHelper : NSObject

+ (void)updataPassword:(UpdatePasswordRequest *)request withBlock:(NetApiUserBlock)block;
+ (void)completeUserInfo:(CompleteInfoRequest *)request withBlock:(NetApiUserBlock)block;
+ (void)updataUserInfo:(UpdateInfoRequest *)request withBlock:(NetApiUserBlock)block;


@end
