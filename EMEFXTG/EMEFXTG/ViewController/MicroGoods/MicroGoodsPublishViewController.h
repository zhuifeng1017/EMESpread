//
//  MicroGoodsPublishViewController.h
//  EMEFXTG
//
//  Created by apple on 15/6/19.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MALTabBarChinldVIewControllerDelegate.h"

@interface MicroGoodsPublishViewController : UIViewController

@property (nonatomic, weak) id<MALTabBarChinldVIewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)preViewBtnClick:(id)sender;
- (IBAction)saveBtnClick:(id)sender;

@end

#pragma mark - MicroGoodsPublishCell
@interface MicroGoodsPublishCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *indicateImageView;

@end
