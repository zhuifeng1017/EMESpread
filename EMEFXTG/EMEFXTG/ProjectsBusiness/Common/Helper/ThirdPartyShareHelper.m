//
//  ThirdPartyShareHelper.m
//  EMESHT
//
//  Created by appeme on 14/12/26.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "ThirdPartyShareHelper.h"
#import "RegExCategories.h"
#import "NetApiArticleHelper.h"
#import "AppCacheManager.h"

@interface ThirdPartyShareHelper ()
@property (copy, nonatomic) NSString *articleId;
@property (strong, nonatomic) Article *article;
@end

@implementation ThirdPartyShareHelper

- (void)processUrl:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    _launchFromThirdPartyApp = YES;

    NSString *urlString = [url resourceSpecifier];

    BOOL isWeixin = NO;
    NSArray *pieces = [urlString split:RX(@"[/;]")];
    for (NSString *line in pieces) {
        if ([line rangeOfString:@"="].length > 0) {
            NSArray *values = [line split:RX(@"=")];
            if (values.count == 2) {
                NSString *key = values[0];
                NSString *value = values[1];

                if ([key isEqual:@"type"] && [value intValue] == 22) {
                    isWeixin = YES;
                }

                if (isWeixin && [key isEqual:@"articleId"]) {
                    _articleId = value;
                }
            }
        }
    }

    [self checkThirdPartyLaunch];
}

- (void)presentArticleViewController {
}

- (void)checkThirdPartyLaunch {
    BOOL isLogin = [AppCacheManager sharedManager].isLogin;
    ThirdPartyShareHelper *helper = [AppCacheManager sharedManager].thirdPartyShareHelper;
    if (helper.launchFromThirdPartyApp) {
        if (helper.articleId) {

            WEAKSELF
            [NetApiArticleHelper getArticle:helper.articleId withBlock:^(NSString *message, Article *article) {
                weakSelf.article = article;
                
                if (isLogin) {
                    [self presentArticleViewController];
                }
                else {
                    weakSelf.needLaunchAfterViewDidLoad = YES;
                    if (weakSelf.autoLoginDelegate) {
                        [weakSelf.autoLoginDelegate launchAutoLogin];
                    }
                }
            }];
        }
    }
}

// 获取当前处于activity状态的view controller
- (UIViewController *)activityViewController {
    UIViewController *activityViewController = nil;

    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }

    NSArray *viewsArray = [window subviews];
    if ([viewsArray count] > 0) {
        UIView *frontView = [viewsArray objectAtIndex:0];

        id nextResponder = [frontView nextResponder];

        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            activityViewController = nextResponder;
        } else {
            activityViewController = window.rootViewController;
        }
    }

    return activityViewController;
}

@end
