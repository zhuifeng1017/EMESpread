//
//  HomeTabBarViewController.m
//  EMEZL
//
//  Created by appeme on 15/4/30.
//  Copyright (c) 2015年 appeme. All rights reserved.
//

#import "HomeTabBarViewController.h"
#import "AppUtils.h"
#import "AddressBookViewController.h"
#import "AppCalendarManager.h"
//#import "MicroGoodsNewViewController.h"
#import "MicroGoodsMineViewController.h"
#import "MicroGoodsPublishViewController.h"

@implementation HomeTabBarViewController
- (id)init {
    return [self init:0];
}

- (id)init:(int)defaultIndex {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNofifyDataChanged:) name:NoticeCalendarChanged object:nil];

    NSMutableArray *itemsArray = [[NSMutableArray alloc] init];
    NSArray *controllerArray = @[ @"MicroGoodsViewController", @"MicroGoodsPublishViewController", @"MicroGoodsMineViewController" ];

    NSArray *normalImageArray = @[ @"mini", @"send", @"my" ];           //item 正常状态下的背景图片
    NSArray *selectedImageArray = @[ @"mini_red", @"send", @"my_red" ]; //item被选中时的图片名称

    for (int i = 0; i < controllerArray.count; i++) {
        MALTabBarItemModel *itemModel = [[MALTabBarItemModel alloc] init];
        itemModel.controllerName = controllerArray[i];
        //        itemModel.itemTitle = titleArray[i];
        itemModel.itemImageName = normalImageArray[i];
        itemModel.selectedItemImageName = selectedImageArray[i];
        [itemsArray addObject:itemModel];
    }

    //    [_tabBarController setTabBarBgImage:@"tabbar_background_os7@2x.png"]; //设置tabBar的背景图片

    if (self = [super initWithItemModels:itemsArray defaultSelectedIndex:defaultIndex]) {
        self.tabBarDelegate = self;
    }
    self.delegate = self;
    self.hidesBottomBarWhenPushed = YES;
    self.theTabBarHeight = 58;
    self.theTabBarMinHeight = 44;
    [self setTabBarBgImage:@"tabbar_background_os7"]; //设置tabBar的背景图片

    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)selectedItem:(MALTabBarItemModel *)selectedItemModel {
//    if (selectedItemModel.itemIndex == 3) {
//    } else {
//    }
//}

- (BOOL)respondsToSelf:(MALTabBarItemModel *)selectedItemModel {
    if (selectedItemModel.itemIndex == 1) {
        MicroGoodsPublishViewController *vc = [[MicroGoodsPublishViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return YES;
    }
    //    } else if (selectedItemModel.itemIndex == 2) {
    //        MicroGoodsMineViewController *vc = [[MicroGoodsMineViewController alloc] init];
    //        [self.navigationController pushViewController:vc animated:YES];
    //        return YES;
    //    }
    return NO;
}

- (void)createChildViewController:(UIViewController *)childViewController index:(int)index {
    if (index == 3) {
        if ([childViewController isKindOfClass:[AddressBookViewController class]]) {
            AddressBookViewController *viewController = (AddressBookViewController *)childViewController;
            viewController.isHideBack = YES;
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification
- (void)onNofifyDataChanged:(NSNotification *)notification {
    [[AppCalendarManager sharedManager] queryCalendar];
}

@end