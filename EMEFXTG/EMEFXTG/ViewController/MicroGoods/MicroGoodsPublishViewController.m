//
//  MicroGoodsPublishViewController.m
//  EMEFXTG
//
//  Created by apple on 15/6/19.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "MicroGoodsPublishViewController.h"
#import "MicroGoodsNewViewController.h"
#import "MicroGoodsForwardRedPacketsViewController.h"
#import "UITableView+EMEUI.h"
#import "MicroGoodsInputAlertViewController.h"
#import "EMEPopViewController.h"
#import "HtmlEditorViewController.h"

@implementation MicroGoodsPublishCell
- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end

static NSString *cellIdentifier = @"cellIdentifier";
#pragma mark - MicroGoodsPublishViewController
@interface MicroGoodsPublishViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *titlesNoInput;
@property (strong, nonatomic) NSMutableArray *titlesHasInput;
@property (strong, nonatomic) NSMutableArray *actionSelectors;
@property (strong, nonatomic) NSMutableArray *flags;
@end

@implementation MicroGoodsPublishViewController

- (void)viewDidLoad {
    self.navigationController.navigationBarHidden = YES;
    [super viewDidLoad];
    _titlesNoInput = [NSMutableArray arrayWithArray:@[ @"创建标题(必填)", @"输入价格(必填)", @"输入良品数量(必填)", @"选择良品类型(必填)", @"添加良品主图(必填)", @"添加良品介绍(必填)", @"添加转发红包(选填)", @"添加营销策略(选填)" ]];
    _titlesHasInput = [NSMutableArray arrayWithArray:@[ @"标题已输入", @"价格已输入", @"良品数量已输入", @"良品类型已输入", @"良品主图已输入", @"添加良品介绍已输入", @"转发红包已输入", @"营销策略已输入" ]];
    _actionSelectors = [NSMutableArray arrayWithArray:@[ @"didSelectTitle", @"didSelectPrice", @"didSelectCount", @"didSelectType", @"didSelectMainPic", @"didSelectDesc", @"didSelectRedPacket", @"didSelectStrategy" ]];
    _flags = [NSMutableArray arrayWithArray:@[ @0, @0, @0, @0, @0, @0, @0, @0 ]];

    _tableView.delegate = self;
    _tableView.dataSource = self;

    UINib *nib = [UINib nibWithNibName:@"MicroGoodsPublishCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];

    [_tableView enableFootView:YES];
}

- (IBAction)preViewBtnClick:(id)sender {
    MicroGoodsNewViewController *vc = [[MicroGoodsNewViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)saveBtnClick:(id)sender {
}

#pragma mark - action selectors
- (void)didSelectTitle {
}

- (void)didSelectPrice {
}

- (void)didSelectCount {
}

- (void)didSelectType {
}

- (void)didSelectMainPic {
}

- (void)didSelectDesc {
}

- (void)didSelectRedPacket {
    MicroGoodsForwardRedPacketsViewController *vc = [[MicroGoodsForwardRedPacketsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectStrategy {
    MicroGoodsInputAlertViewController *alertVC = [[MicroGoodsInputAlertViewController alloc] init];
    EMEPopViewController *popViewController = [[EMEPopViewController alloc] initWithRootViewController:alertVC];
    [self pushViewController:popViewController animated:YES popStyle:EMEPopStyleFromBottom];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 33.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titlesNoInput count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MicroGoodsPublishCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(MicroGoodsPublishCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL hasInput = [_flags[indexPath.row] intValue] != 0;
    cell.accessoryType = hasInput ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
    cell.indicateImageView.hidden = !hasInput;
    cell.titleLabel.text = hasInput ? _titlesHasInput[indexPath.row] : _titlesNoInput[indexPath.row];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSelector:NSSelectorFromString(_actionSelectors[indexPath.row]) withObject:nil];
    //_flags[indexPath.row] = @1;
    //[_tableView reloadData];
    
    HtmlEditorViewController *vc = [[HtmlEditorViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
