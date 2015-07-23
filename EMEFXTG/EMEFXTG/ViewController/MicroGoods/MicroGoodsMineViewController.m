//
//  MicroGoodsMineViewController.m
//  EMEFXTG
//
//  Created by apple on 15/6/12.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "MicroGoodsMineViewController.h"
#import "MicroGoodsWXLoginViewController.h"
#import "AppUtils.h"
#import <ShareSDK/ShareSDK.h>

@interface MicroGoodsMineViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *itemTitles;
@end

@implementation MicroGoodsMineViewController

- (void)viewDidLoad {
    self.navigationController.navigationBarHidden = YES;
    [super viewDidLoad];

    _itemTitles = @[ @"我的提现", @"我的良品", @"修改密码", @"个人资料", @"关于我们", @"服务热线" ];
    [_picImageView toCircle];
    _tableView.tableHeaderView = _headerView;
    _tableView.tableFooterView = _footerView;
    [_headerView setBackgroundColor:[UIColor colorWithHexString:@"CC3333"]];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    _moneyLabel.text = [AppUtils moneyFormateString:100000000];
}

- (IBAction)exitBtnClick:(id)sender {
    [AppCacheManager sharedManager].isLogin = NO;
    [AppCacheManager sharedManager].loginUser = nil;
    [AppCacheManager sharedManager].loginUserId = nil;

    [ShareSDK cancelAuthWithType:ShareTypeWeixiSession];

    [AppUtils showGlobalHUD:@"退出登录成功"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_itemTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [_itemTitles objectAtIndex:indexPath.row];

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (![AppCacheManager sharedManager].isLogin) {
        MicroGoodsWXLoginViewController *vc = [[MicroGoodsWXLoginViewController alloc] init];
        [self.navigationController presentViewController:vc animated:YES completion:NULL];
    } else {
        [AppUtils showAlertView:@"功能正在开发中..." message:nil];
    }
}

@end
