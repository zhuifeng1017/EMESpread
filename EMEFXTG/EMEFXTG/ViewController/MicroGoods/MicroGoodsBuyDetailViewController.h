//
//  MicroGoodsBuyDetailViewController.h
//  EMEFXTG
//
//  Created by appeme on 15/6/11.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MicroGoodsBuyDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@end

@interface MicroGoodsBuyDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
