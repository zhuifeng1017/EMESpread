//
//  SpreadDetailViewController.m
//  EMEFXTG
//
//  Created by appeme on 15/7/20.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "SpreadDetailViewController.h"
#import "SpreadItemCell.h"

@interface SpreadDetailViewController ()

@end

static NSString *cellReuseIdentifier = @"cellReuseIdentifier";

@implementation SpreadDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UINib *nib = [UINib nibWithNibName:@"SpreadScoreCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:cellReuseIdentifier];

    _tableView.tableHeaderView = self.headView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    SpreadScoreCell *scoreCell = (SpreadScoreCell *)cell;
    [scoreCell setStars:random() % 5];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
