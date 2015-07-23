//
//  TipNotMakeViewController.m
//  EMESHT
//
//  Created by xuanhr on 15/1/26.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "TipNotMakeViewController.h"
#import "MALTabBarViewController.h"
#import "MALTabBar.h"

@interface TipNotMakeViewController ()

@end

@implementation TipNotMakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setTabBadgetNumber {
    MALTabBar *tabbar = [MALTabBarViewController getTabBar:self].tabBar;
    for (int i = 0; i < tabbar.items.count; i++) {
        MALTabBarItem *buttonItem = (MALTabBarItem *)tabbar.items[i];
        [buttonItem setItemBadgeBackgroundStyle:CGRectMake(320 / 4 - 28, 6, 21, 10) blurColor:[UIColor redColor] highLightColor:[UIColor whiteColor] cornerRadius:5 borderColor:[UIColor clearColor] borderWidth:0];
        [buttonItem setItemBadgeFontStyle:[UIFont fontWithName:@"Helvetica-Bold" size:10] blurColor:[UIColor whiteColor] highLightColor:[UIColor redColor]];
    }

    [[MALTabBarViewController getTabBar:self].tabBar setItemBadgeNumberWithIndex:0 badgeNumber:1 badgetRect:CGRectMake(320 / 4 - 18, 6, 10, 10)];
    [[MALTabBarViewController getTabBar:self].tabBar setItemBadgeNumberWithIndex:1 badgeNumber:3 badgetRect:CGRectMake(320 / 4 - 18, 6, 10, 10)];
    [[MALTabBarViewController getTabBar:self].tabBar setItemBadgeNumberWithIndex:2 badgeNumber:99 badgetRect:CGRectMake(320 / 4 - 22, 6, 16, 10)];
    [[MALTabBarViewController getTabBar:self].tabBar setItemBadgeNumberWithIndex:3 badgeNumber:999];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
