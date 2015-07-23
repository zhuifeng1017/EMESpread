//
//  HomeTabBarViewController.h
//  EMEZL
//
//  Created by appeme on 15/4/30.
//  Copyright (c) 2015年 appeme. All rights reserved.
//

#import "MALTabBar.h"
#import "MALTabBarViewController.h"

@interface HomeTabBarViewController : MALTabBarViewController<MALTabBarDelegate, MALTabBarChinldVIewControllerDelegate>
- (id)init:(int)defaultIndex;
@end
