//
//  MoreViewController.h
//  EMEHS
//
//  Created by xuanhr on 14-8-14.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeSkinViewController.h"
#import "Harpy.h"

@interface MoreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, HarpyDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *labelTextColor;
@property (strong, nonatomic) NSArray *myArry;
@property (strong, nonatomic) ChangeSkinViewController *ChangeSkinVC;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
- (void)addView;
@end
