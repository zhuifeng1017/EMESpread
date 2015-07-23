//
//  MicroGoodsViewController.h
//  EMEFXTG
//
//  Created by appeme on 15/6/9.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MALTabBarChinldVIewControllerDelegate.h"

@interface MicroGoodsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) id<MALTabBarChinldVIewControllerDelegate> delegate;
@end
