//
//  MicroGoodsDetailViewController.m
//  EMEFXTG
//
//  Created by appeme on 15/6/11.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "MicroGoodsDetailViewController.h"
#import "EScrollerView.h"
#import "MicroGoodsCouponCell.h"
#import "MicroGoodsBuyDetailViewController.h"
#import "EMEPopViewController.h"
#import "MicroGoodsPopDetailViewController.h"
#import "MicroGoodsPurchasePolicyViewController.h"

@interface MicroGoodsDetailViewController () <UITableViewDelegate, UITableViewDataSource, NIAttributedLabelDelegate>

@end

static NSString *cellIdentifier = @"cellIdentifier";

@implementation MicroGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"3斤荔枝";
    
    NSArray *imageArray = @[ @"figure", @"figure" ];

    EScrollerView *eScrollerView = [[EScrollerView alloc] initWithFrameRect:_eScrollerBG.bounds ImageArray:imageArray TitleArray:nil];
    [_eScrollerBG addSubview:eScrollerView];

    eScrollerView.pageControl.top = 38;
    eScrollerView.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    eScrollerView.pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"FB4E47"];

    [eScrollerView.noteView setBackgroundColor:[UIColor clearColor]];
    eScrollerView.noteTitle.hidden = NO;
    eScrollerView.noteTitle.font = [UIFont boldSystemFontOfSize:17];
    eScrollerView.noteTitle.textColor = [UIColor whiteColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UINib* nib = [UINib nibWithNibName:@"MicroGoodsCouponCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    
    [self refreshTableView];
    self.scrollView.contentSize = CGSizeMake(320, _tableView.bottom);
    
    _buyDetailLabel.underlineStyle = kCTUnderlineStyleSingle;
    _buyDetailLabel.verticalTextAlignment = NIVerticalTextAlignmentMiddle;
    _buyDetailLabel.tag = 1;
    [_buyDetailLabel setDelegate:self];
    
    NSRange linkRange = NSMakeRange(0, _buyDetailLabel.text.length);
    [_buyDetailLabel addLink:nil range:linkRange];
    _buyDetailLabel.linkColor = [UIColor colorWithHexString:@"ff3333"];
    
    _activityDetailLabel.underlineStyle = kCTUnderlineStyleSingle;
    _activityDetailLabel.verticalTextAlignment = NIVerticalTextAlignmentMiddle;
    _activityDetailLabel.tag = 2;
    [_activityDetailLabel setDelegate:self];

    linkRange = NSMakeRange(0, _activityDetailLabel.text.length);
    [_activityDetailLabel addLink:nil range:linkRange];
    _activityDetailLabel.linkColor = [UIColor colorWithHexString:@"ff3333"];
    
    _microGoodsDetailLabel.underlineStyle = kCTUnderlineStyleSingle;
    _microGoodsDetailLabel.verticalTextAlignment = NIVerticalTextAlignmentMiddle;
    _microGoodsDetailLabel.tag = 3;
    [_microGoodsDetailLabel setDelegate:self];
    
    linkRange = NSMakeRange(0, _microGoodsDetailLabel.text.length);
    [_microGoodsDetailLabel addLink:nil range:linkRange];
    _microGoodsDetailLabel.linkColor = [UIColor colorWithHexString:@"ff3333"];
}

- (void)refreshTableView {
    _tableView.height = [self tableView:nil heightForRowAtIndexPath:nil] * [self tableView:nil numberOfRowsInSection:0];
}

- (void)attributedLabel:(NIAttributedLabel *)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point {
    
    if (attributedLabel.tag == 1) {
        MicroGoodsBuyDetailViewController *vc = [[MicroGoodsBuyDetailViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (attributedLabel.tag == 2) {
        MicroGoodsPopDetailViewController *vc = [[MicroGoodsPopDetailViewController alloc] init];
        EMEPopViewController *popupViewController = [[EMEPopViewController alloc] initWithRootViewController:vc];
        [self pushViewController:popupViewController animated:YES popStyle:EMEPopStyleFromBottom];        
    }
    else if (attributedLabel.tag == 3) {
        MicroGoodsPurchasePolicyViewController *vc = [[MicroGoodsPurchasePolicyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 30;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    MicroGoodsCouponCell* cell = (MicroGoodsCouponCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [cell setBackgroundStyle:indexPath.row];
    
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

- (IBAction)awardsClick:(id)sender {
}

- (IBAction)buyClick:(id)sender {
}
@end
