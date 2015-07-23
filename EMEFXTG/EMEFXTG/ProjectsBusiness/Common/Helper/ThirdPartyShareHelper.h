//
//  ThirdPartyShareHelper.h
//  EMESHT
//
//  Created by appeme on 14/12/26.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ThirdPartyShareAutoLoginDelegate
- (void)launchAutoLogin;
@end

@interface ThirdPartyShareHelper : NSObject
@property (assign, nonatomic) BOOL launchFromThirdPartyApp;
@property (assign, nonatomic) BOOL needLaunchAfterViewDidLoad;
@property (weak, nonatomic) id<ThirdPartyShareAutoLoginDelegate> autoLoginDelegate;
- (void)processUrl:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (void)presentArticleViewController;
@end
