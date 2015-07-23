//
//  PopupMenuHelper.m
//  EMESHT
//
//  Created by appeme on 14-10-17.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "PopupMenuHelper.h"
#import "EMEPopViewController.h"
#import "UIViewController+AnimationExtensions.h"
#import "AddressBookViewController.h"
#import "UIView+EMEFW.h"
#import "Article.h"

@interface PopupMenuHelper ()
@property (weak, nonatomic) UIViewController *viewController;
@end

@implementation PopupMenuHelper

+ (PopupMenuHelper *)sharedInstance {
    static PopupMenuHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PopupMenuHelper alloc] init];
        
        NSArray *icons = @[[UIImage imageNamed:@"pop_plan"],[UIImage imageNamed:@"pop_activity"],[UIImage imageNamed:@"pop_inviter"],[UIImage imageNamed:@"pop_notice"],[UIImage imageNamed:@"pop_gnosis"],[UIImage imageNamed:@"pop_chat"]];
        NSArray *selectedIcons = @[[UIImage imageNamed:@"pop_plan"],[UIImage imageNamed:@"pop_activity"],[UIImage imageNamed:@"pop_invite"],[UIImage imageNamed:@"pop_notice"],[UIImage imageNamed:@"pop_gnosis"],[UIImage imageNamed:@"pop_chat"]];

        CHPopUpMenu *popUp = [[CHPopUpMenu alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 55, [UIScreen mainScreen].bounds.size.height - 115, 60, 60)
                                                     direction:-M_PI/4
                                                     iconArray:icons
                                             selectedIconArray:selectedIcons mainIcon:[UIImage imageNamed:@"pop"]];
        popUp.delegate = instance;
        instance.popupMenu = popUp;
    });

    return instance;
}

- (void)attachToView:(UIView *)view onViewController:(UIViewController *)viewController top:(int)top {
    UIView *popupView = [PopupMenuHelper sharedInstance].popupMenu;
    [popupView removeFromSuperview];
    [view addSubview:popupView];

    popupView.top = top;

    if (viewController) {
        _viewController = viewController;
    }
}

- (void)popupMenuClicked:(int)senderTag {
    if (senderTag == 0) { // 提醒
    }
}

@end
