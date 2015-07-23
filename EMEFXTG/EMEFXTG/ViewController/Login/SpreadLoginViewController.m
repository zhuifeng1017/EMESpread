//
//  SpreadLoginViewController.m
//  EMEFXTG
//
//  Created by appeme on 15/7/20.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "SpreadLoginViewController.h"
#import "AppDelegate.h"
#import "AppUtils.h"
#import "NetApiHelper.h"
#import "Login.h"
#import "AppCacheManager.h"
#import "SMSAuthViewController.h"


@interface SpreadLoginViewController ()

@end

@implementation SpreadLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClick:(id)sender {
    [((AppDelegate *)[UIApplication sharedApplication].delegate)thirdPartyLoginInfo:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        if (!result) {
            [AppUtils showAlertView:@"" message:[error errorDescription]];
            return;
        }
        NSDictionary *dict = [userInfo sourceData];
        
        NSString *unionid = dict[@"unionid"];
        NSString *token = [[userInfo credential] token];
        NSString *openId = [[userInfo credential] uid];
        NSLog(@"openId: %@", openId);
        NSLog(@"unionid: %@", unionid);
        
        WXUser *user = [[WXUser alloc] init];
        user.openid = openId;
        user.nickname = dict[@"nickname"];
        user.headimgurl = dict[@"headimgurl"];
        user.sex = dict[@"sex"];
        user.province = dict[@"province"];
        user.city = dict[@"city"];
        
        WXLoginRequest *request = [[WXLoginRequest alloc] init];
        request.accessToken = token;
        request.unionId = unionid;
        request.openid = openId;
        request.uInfo = user;
        [NetApiHelper sendRequest:request forResponse:[WXLogin class] loadingTip:YES errorTip:YES successTip:nil withBlock:^(NSString *message, id response) {
            if ([message isEqualToString:@"success"]) { // 微信登陆成功
                WXLogin *login = (WXLogin*)response;
                [AppCacheManager sharedManager].isLogin = YES;
                [AppCacheManager sharedManager].loginUserId = login.id;
                [AppCacheManager sharedManager].wxloginUser = login;
                [AppCacheManager sharedManager].wxUnionId = unionid;
                NSLog(@"loginUserId : %@", login.id);
                
                if ([login.loginName isBlank]) {
                    SMSAuthViewController *vc = [[SMSAuthViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [AppUtils showGlobalHUD:@"登录成功"];
                }
            }
        }];
    }];
}

@end
