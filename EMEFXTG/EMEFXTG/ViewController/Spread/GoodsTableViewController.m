//
//  GoodsTableViewController.m
//  EMEFXTG
//
//  Created by Mac on 15-7-22.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "GoodsTableViewController.h"
#import "SpreadInfoVCell.h"
#import "BasePopViewController.h"
#import "DetailsViewController.h"
#import "SpreadDetailViewController.h"

@interface GoodsTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) BasePopViewController *popOpenModeViewController;
@end

@implementation GoodsTableViewController

static NSString *cellIdentifier = @"cellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;

    UINib *nib = [UINib nibWithNibName:@"SpreadInfoVCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 360;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SpreadInfoVCell *cell = (SpreadInfoVCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    cell.infoView.imageView.image = [UIImage imageNamed:(indexPath.row % 2 ? @"preview1" : @"preview2")];
    cell.infoView.shareNumLabel.text = [NSString stringWithFormat:@"剩余%ld个", indexPath.row];
    cell.infoView.rewardLabel.text = [NSString stringWithFormat:@"￥%ld", indexPath.row * 10];
    cell.infoView.payLabel.text = [NSString stringWithFormat:@"￥%ld", indexPath.row * 100];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _popOpenModeViewController = [[BasePopViewController alloc] initWithCustomXib:@"SpreadOpenEditModePopView"];
    UIView *customView = [_popOpenModeViewController showPopOn:self.parentViewController withBackgroundColor:[UIColor colorWithHexString:@"33000000"]];
    UIButton *detailButton = (UIButton *)[customView viewWithTag:1];
    UIButton *spreadDetailButton = (UIButton *)[customView viewWithTag:2];

    [detailButton addTarget:self action:@selector(detailClick:) forControlEvents:UIControlEventTouchUpInside];
    [spreadDetailButton addTarget:self action:@selector(spreadDetailClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)detailClick:(id)sender {
    [_popOpenModeViewController dismiss:YES];

    // Product *product = _cards[0];

    DetailsViewController *vc = [[DetailsViewController alloc] init];
    // vc.paramProduct = product;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)spreadDetailClick:(id)sender {
    [_popOpenModeViewController dismiss:YES];

    //  Product *product = _cards[0];

    SpreadDetailViewController *vc = [[SpreadDetailViewController alloc] init];
    //vc.paramProduct = product;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
