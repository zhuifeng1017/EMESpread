//
//  MicroGoodsViewController.m
//  EMEFXTG
//
//  Created by appeme on 15/6/9.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "MicroGoodsViewController.h"
#import "MicroGoodsCell.h"
#import "MicroGoodsDetailViewController.h"
#import "AppUtils.h"

@interface MicroGoodsViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MicroGoodsViewController

static NSString *cellIdentifier = @"cellIdentifier";

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden = YES;
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UINib* nib = [UINib nibWithNibName:@"MicroGoodsCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    
    self.titleLabel.text = @"良品(0)";
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 80;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    MicroGoodsCell* cell = (MicroGoodsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [AppUtils sd_setWebImage:cell.imageView withUrl:@"figure2"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MicroGoodsDetailViewController *vc = [[MicroGoodsDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
