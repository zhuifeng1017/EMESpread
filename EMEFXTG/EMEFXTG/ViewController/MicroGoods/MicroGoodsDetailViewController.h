//
//  MicroGoodsDetailViewController.h
//  EMEFXTG
//
//  Created by appeme on 15/6/11.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIAttributedLabel.h"

@interface MicroGoodsDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *eScrollerBG;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NIAttributedLabel *buyDetailLabel;
@property (weak, nonatomic) IBOutlet NIAttributedLabel *activityDetailLabel;
@property (weak, nonatomic) IBOutlet NIAttributedLabel *microGoodsDetailLabel;
- (IBAction)awardsClick:(id)sender;
- (IBAction)buyClick:(id)sender;

@end
