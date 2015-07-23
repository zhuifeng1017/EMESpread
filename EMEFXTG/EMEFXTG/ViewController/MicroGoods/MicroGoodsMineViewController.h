//
//  MicroGoodsMineViewController.h
//  EMEFXTG
//
//  Created by apple on 15/6/12.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MALTabBarChinldVIewControllerDelegate.h"

@interface MicroGoodsMineViewController : UIViewController

@property (nonatomic, weak) id<MALTabBarChinldVIewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
- (IBAction)exitBtnClick:(id)sender;
@end
