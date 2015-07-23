//
//  PersonCenterViewController.m
//  EMEZL
//
//  Created by apple on 15/3/17.
//  Copyright (c) 2015年 appeme. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "AppUtils.h"
#import "EMEPopViewController.h"
#import "UIAlertView+Blocks.h"
#import "NetApiFriendHelper.h"
#import "EMEDatabaseManager.h"
#import "AllUserEntity.h"
#import "UIImageView+WebCache.h"
#import "GoodsTableViewController.h"

@interface PersonCenterViewController ()
@property (strong, nonatomic) GoodsTableViewController *spreadTableVC;
@property (strong, nonatomic) GoodsTableViewController *goodsTableVC;
@property (assign, nonatomic) BOOL isFriend;
@end

@implementation PersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _userLabel.text = _user.name ?: @"未知";

//    User *user = [AppUtils getUserById:_user.id];
//    if (user) {
//        NSMutableString *stringJobs = [[NSMutableString alloc] init];
//
//        [stringJobs appendString:user.company.name];
//
//        for (int i = 0; i < user.job.position.count && i < 2; i++) {
//            NSString *stringJob = user.job.position[i];
//            if (stringJob) {
//                [stringJobs appendString:@"/"];
//                [stringJobs appendString:stringJob];
//            }
//        }
//        _dutyLabel.text = [stringJobs copy];
//    }

    [AppUtils sd_setWebImage:_peopleImageView withUrl:_user.icon ?: @"preview1"];

    [_peopleImageView toCircle];

    [self configureView];
}

- (void)configureView {
    _globalScrollContainer.topView.fixedButtonCount = 2;
    _globalScrollContainer.topView.nameArray = @[ @"传播", @"商品" ];
    _globalScrollContainer.rootView.viewNameArray = _globalScrollContainer.topView.nameArray;
    
    _globalScrollContainer.topView.titleFontBlurColor = @"FB4F48";
    _globalScrollContainer.topView.titleFontFocusColor = @"313131";
    
    [_globalScrollContainer.topView initWithNameButtons];
    [_globalScrollContainer.rootView initWithViews];
    
    _spreadTableVC = [[GoodsTableViewController alloc] init];
    [_globalScrollContainer addChildViewController:_spreadTableVC];
    
    _goodsTableVC = [[GoodsTableViewController alloc] init];
    [_globalScrollContainer addChildViewController:_goodsTableVC];
    
    _globalScrollContainer.rootContentSize = CGSizeMake(_globalScrollContainer.rootView.contentSize.width, 0);
}

#pragma mark - request
- (void)queryFriendRequest {
}

@end
