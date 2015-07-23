//
//  BaseHelper.h
//  EMESHT
//
//  Created by xuanhr on 15/1/20.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Login.h"
#import "Version.h"

typedef void (^NetApiBaseBlock)(NSString *message, Login *login);
typedef void (^NetApiBaseVersionBlock)(NSString *message, Version *version);

@interface NetApiBaseHelper : NSObject
+ (void)sendRegister:(RegisterRequest *)request withBlock:(NetApiBaseBlock)block;
+ (void)sendLogin:(LoginRequest *)request withBlock:(NetApiBaseBlock)block;
+ (void)sendLoginOutWithBlock:(NetApiBaseBlock)block;
+ (void)sendCheckVersion:(CheckVersionRequest *)request withBlock:(NetApiBaseVersionBlock)block;
@end
