//
//  MicroGoodsWXLoginViewController.m
//  EMEFXTG
//
//  Created by apple on 15/6/12.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "MicroGoodsWXLoginViewController.h"
#import "AppDelegate.h"
#import "AppUtils.h"
#import "NetApiHelper.h"

@interface MicroGoodsWXLoginViewController ()

@end

@implementation MicroGoodsWXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)loginBtnClick:(id)sender {
    [((AppDelegate *)[UIApplication sharedApplication].delegate)thirdPartyLoginInfo:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        if (!result) {
            [AppUtils showAlertView:@"" message:[error errorDescription]];
            return;
        }
        
        NSDictionary *dict = [userInfo sourceData];
        NSString *token = [[userInfo credential] token];
        NSString *openId = [[userInfo credential] uid];
        
        WXUser *user = [[WXUser alloc] init];
        user.openid = openId;
        user.nickname = dict[@"nickname"];
        user.headimgurl = dict[@"headimgurl"];
        user.sex = dict[@"sex"];
        user.province = dict[@"province"];
        user.city = dict[@"city"];
        
        WXLoginRequest *request = [[WXLoginRequest alloc] init];
        request.accessToken = token;
        request.openid = openId;
        request.uInfo= user;
        
        WEAKSELF;
        [NetApiHelper sendRequest:request forResponse:[Login class] loadingTip:YES errorTip:YES successTip:@"登录成功" withBlock:^(NSString *message, id response) {
            if ([message isEqualToString:@"success"]) {
                Login *login = (Login*)response;
                [AppCacheManager sharedManager].isLogin = YES;
                [AppCacheManager sharedManager].loginUserId = login.id;
                [AppCacheManager sharedManager].loginUser = login;
                
                [weakSelf dismissViewControllerAnimated:YES completion:NULL];
            }
        }];
    }];
}

@end
