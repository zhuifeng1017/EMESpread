//
//  MicroGoodsBuyDetailViewController.m
//  EMEFXTG
//
//  Created by appeme on 15/6/11.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "MicroGoodsBuyDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "AppUtils.h"

@interface MicroGoodsBuyDetailViewController ()  <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MicroGoodsBuyDetailViewController

static NSString *cellIdentifier = @"cellIdentifier";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UINib* nib = [UINib nibWithNibName:@"MicroGoodsBuyDetailCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 2, 290, 10)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"eeee00"];
    [lineView drawDebug];
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
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 29, 290, .5)];
    lineView.backgroundColor = [tableView separatorColor];
    lineView.layer.zPosition = 1;
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    headLabel.backgroundColor = _tableView.backgroundColor;
    headLabel.text = @"      参团人员";
    headLabel.textColor = [UIColor grayColor];
    headLabel.font = [UIFont systemFontOfSize:13];

    [headLabel addSubview:lineView];
    
    return headLabel;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    MicroGoodsBuyDetailCell* cell = (MicroGoodsBuyDetailCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    [AppUtils sd_setWebImage:cell.picView withUrl:@"figure2"];
    cell.contentLabel.text = @"1891***212";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end


@implementation MicroGoodsBuyDetailCell

- (void)awakeFromNib {
    [_picView toCircle];
    [_orderLabel toCircle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end