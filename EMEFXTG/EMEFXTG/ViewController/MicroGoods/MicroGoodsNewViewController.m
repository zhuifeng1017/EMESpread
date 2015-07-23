//
//  MicroGoodsNewViewController.m
//  EMEFXTG
//
//  Created by apple on 15/6/12.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "MicroGoodsNewViewController.h"
#import "UIView+BeefyLayout.h"
#import "MicroGoodsForwardRedPacketsViewController.h"
#import "MicroGoodsPurchasePolicyViewController.h"
#import "ImagePicker.h"
#import "UploadImageView.h"
#import "AppUtils.h"

@interface MicroGoodsNewViewController () <EMEGridViewDataSource>
@property (strong, nonatomic) ImagePicker *imagePicker;
@property (strong, nonatomic) NSMutableArray *uploadImageViewArray;
@end

@implementation MicroGoodsNewViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    self.needKeyboardAssist = YES;
    self.navigationController.navigationBarHidden = YES;
    [super viewDidLoad];

    [self configureView];
    [self resetStackPanelSize];
}

- (void)configureView {
    _mainPicView.height = 33;

    NSArray *views = @[ _titleView, _priceView, _typeView, _mainPicView, _detailView, _forwardView, _strategyView ];
    NSArray *actions = @[ @"", @"", @"typeBtnClick:", @"mainPicBtnClick:", @"", @"forwardBtnClick:", @"strategyBtnClick:" ];
    for (int i = 0; i < views.count; ++i) {
        UIView *view = views[i];
        [_stackPanel addSubview:view];

        if ([actions[i] length] != 0) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [view addSubview:btn];
            btn.frame = view.bounds;
            [btn addTarget:self action:NSSelectorFromString(actions[i]) forControlEvents:(UIControlEventTouchUpInside)];
        }
    }
}

- (void)resetStackPanelSize {
    WEAKSELF;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.stackPanel.height = [weakSelf stackPanelHeight];
        weakSelf.scrollView.contentSize = CGSizeMake(weakSelf.scrollView.width, weakSelf.stackPanel.height);
    });
}

- (float)stackPanelHeight {
    float height = 0;
    for (UIView *view in [self.stackPanel subviews]) {
        height += view.height;
        height += view.marginTop;
        height += view.marginBottom;
    }
    return height;
}

- (IBAction)typeBtnClick:(id)sender {
    MicroGoodsForwardRedPacketsViewController *vc = [[MicroGoodsForwardRedPacketsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)mainPicBtnClick:(id)sender {
    if ([_uploadImageViewArray count] >= 1) {
        [AppUtils showAlertView:@"" message:@"最多只能发表1张图片"];
        return;
    }

    if (_imagePicker == nil) {
        _imagePicker = [[ImagePicker alloc] init];
    }

    _imagePicker.viewController = self;
    _imagePicker.delegate = self;
    _imagePicker.aspectRatio = 1;
    [_imagePicker startAlert];
}

- (IBAction)forwardBtnClick:(id)sender {
    MicroGoodsForwardRedPacketsViewController *vc = [[MicroGoodsForwardRedPacketsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)strategyBtnClick:(id)sender {
    MicroGoodsPurchasePolicyViewController *vc = [[MicroGoodsPurchasePolicyViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - imagePicker delegate
- (void)getPickerImage:(UIImage *)image tag:(int)viewTag error:(NSString *)error {
    if (image == nil) {
        return;
    }

    _picGirdView.hidden = NO;
    _picGirdView.dataSource = self;
    if (_uploadImageViewArray == nil) {
        _uploadImageViewArray = [NSMutableArray array];
    }

    int width = _picGirdView.width / 4;
    UploadImageView *uploadImageView = [[UploadImageView alloc] initWithFrame:(CGRect) {0, 0, width - 10, width - 10}];
    [uploadImageView setImage:image];

    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    [uploadImageView startUploadJpeg:imageData];
    [_uploadImageViewArray addObject:uploadImageView];

    [_picGirdView reloadViews];
    self.mainPicView.height = 110;
    [self resetStackPanelSize];
}

#pragma mark - EMEGridView dataSource
- (UIView *)gridViewForIndex:(EMEGridView *)gridView index:(int)index;
{
    int width = _picGirdView.width / 4;
    UIView *view = [[UIView alloc] initWithFrame:(CGRect) {0, 0, width, width}];

    UploadImageView *uploadImageView = _uploadImageViewArray[index];
    uploadImageView.height = uploadImageView.width = width - 10;
    [view addSubview:uploadImageView];
    uploadImageView.center = view.center;

    UIButton *delBtn = [[UIButton alloc] initWithFrame:(CGRect) {0, 0, 30, 30}];
    [delBtn setImage:[UIImage imageNamed:@"page_group_btn_del"] forState:UIControlStateNormal];
    [view addSubview:delBtn];
    delBtn.center = CGPointMake(uploadImageView.right - 3, uploadImageView.top + 3);
    delBtn.tag = index;
    [delBtn addTarget:self action:@selector(delPictureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return view;
}

- (int)gridViewItemsCount:(EMEGridView *)gridView {
    return (int)[_uploadImageViewArray count];
}

- (void)delPictureBtnClick:(UIButton *)sender {
    int index = (int)sender.tag;
    [_uploadImageViewArray removeObjectAtIndex:index];
    [_picGirdView reloadViews];
}

#pragma mark - getUploadImages

- (BOOL)getUploadImages:(NSMutableArray *)contentArray {
    for (UploadImageView *upView in _uploadImageViewArray) {
        if (upView.status == UploadStatusProcessing) {
            [AppUtils showAlertView:@"" message:@"上传图片中,请稍后再试"];
            return NO;
        }
        [contentArray addObject:upView.responseUrl];
    }
    return YES;
}

@end
