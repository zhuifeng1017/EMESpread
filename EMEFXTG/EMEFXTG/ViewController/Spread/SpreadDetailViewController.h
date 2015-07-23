//
//  SpreadDetailViewController.h
//  EMEFXTG
//
//  Created by appeme on 15/7/20.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface SpreadDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) Product *paramProduct;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;

@end
