//
//  MySpreadViewController.m
//  EMEFXTG
//
//  Created by Apple on 15/7/22.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "MySpreadViewController.h"
#import "GoodsTableViewController.h"

@interface MySpreadViewController ()
@property (strong, nonatomic) GoodsTableViewController *spreadTableVC;
@end

@implementation MySpreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    _spreadTableVC = [[GoodsTableViewController alloc] init];
    [self addChildViewController:_spreadTableVC];
    [self.tableContainer addSubview:_spreadTableVC.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
