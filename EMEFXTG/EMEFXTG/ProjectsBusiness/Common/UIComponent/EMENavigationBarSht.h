//
//  EMENavigationBarSht.h
//  EMESHT
//
//  Created by xuanhr on 15/1/27.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "EMENavigationBar.h"

@protocol EMENavigationBarShtDelegate
@optional
- (BOOL)needShtNavigation;
@end

@interface EMENavigationBarSht : EMENavigationBar
-(void)reloadPeopleIcon;
@end
