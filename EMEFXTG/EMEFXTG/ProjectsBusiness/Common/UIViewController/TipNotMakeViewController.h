//
//  TipNotMakeViewController.h
//  EMESHT
//
//  Created by xuanhr on 15/1/26.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "EMEViewController.h"
#import "MALTabBarViewController.h"
#import "EMEViewController.h"

@interface TipNotMakeViewController : EMEViewController
@property (nonatomic, weak) id<MALTabBarChinldVIewControllerDelegate> delegate;
@property (assign, nonatomic) BOOL isHideBack;
@end
