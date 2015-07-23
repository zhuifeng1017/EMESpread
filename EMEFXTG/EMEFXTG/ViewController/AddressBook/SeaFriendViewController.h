//
//  SeaFriendViewController.h
//  EMESHT
//
//  Created by appeme on 15/2/27.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMEViewController2.h"

@class SeaFriendTableViewController;
@class User;

@interface SeaFriendViewController : EMEViewController
// 外部传入参数

@property (strong, nonatomic) User *user;

@property (weak, nonatomic) IBOutlet UIView *backView;
@end
