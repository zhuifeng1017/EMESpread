//
//  EMENavigationBar.m
//  EMESHT
//
//  Created by xuanhr on 14-11-11.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "EMENavigationBar.h"
#import "MoreViewController.h"

@implementation EMENavigationBar (SHT)

- (void)doSetting:(UIView *)sender {
    if (self.viewController && [self.viewController respondsToSelector:@selector(doSettingClick:)]) {
        [(id<EMENavigationBarDelegate>)self.viewController doSettingClick:sender];
    } else if (self.viewController && [self.viewController respondsToSelector:@selector(doSettingClick)]) {
        [(id<EMENavigationBarDelegate>)self.viewController doSettingClick];
    } else {
        MoreViewController *moreVC = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
        moreVC.labelTextColor = @"8F8F8F";
        [self.viewController addChildViewController:moreVC];
        [moreVC addView];
    }
}
@end
