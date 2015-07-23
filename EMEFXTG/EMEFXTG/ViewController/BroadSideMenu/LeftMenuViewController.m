//
//  LeftMenuViewController.m
//  EMESHT
//
//  Created by appeme on 15/6/26.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SlideNavigationController.h"
#import "AppUtils.h"
#import "SpreadViewController.h"
#import "PersonCenterViewController.h"
#import "MySpreadViewController.h"
#import "WalletViewController.h"
#import "MySettingViewController.h"
@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _picView.image = [UIImage imageNamed:@"preview1"];
    [_picView toCircle];
//    [AppUtils sd_setWebImage:];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 1) {//发现
        [[SlideNavigationController sharedInstance] closeMenuWithCompletion:nil];
    }
    else if (sender.tag == 2) {//钱包
        WalletViewController *wallet = [[WalletViewController alloc]init];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:wallet withSlideOutAnimation:NO andCompletion:nil];
        //[AppUtils showAlertView:@"" message:@"'产品众筹'功能正在拼命开发中..."];
    }
    else if (sender.tag == 3) {//我的传播
        MySpreadViewController *vc = [[MySpreadViewController alloc] init];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc withSlideOutAnimation:NO andCompletion:nil];
    }
    else if (sender.tag == 4) {//我的关注
        [AppUtils showAlertView:@"" message:@"'我的关注'功能正在拼命开发中..."];
    }
    else if (sender.tag == 5) {//个人中心
        PersonCenterViewController *vc = [[PersonCenterViewController alloc] init];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc withSlideOutAnimation:NO andCompletion:nil];
    }
    else if (sender.tag == 6) {//设置
        MySettingViewController *vc = [[MySettingViewController alloc] init];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc withSlideOutAnimation:NO andCompletion:nil];
    }
    else if (sender.tag == 7) {//推荐给好友
        [AppUtils showAlertView:@"推荐给好友" message:@"'xx'功能正在拼命开发中..."];
    }
    else {
        [AppUtils showAlertView:@"" message:@"'xx'功能正在拼命开发中..."];
    }

}
@end
