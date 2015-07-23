//
//  ReleaseGoodsIntroViewController.m
//  EMEFXTG
//
//  Created by apple on 15/7/23.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "PublishStep1ViewController.h"
#import "ImagePicker.h"
#import "UploadImageView.h"
#import "AppUtils.h"

@interface PublishStep1ViewController () <EMEGridViewDataSource>
@property (strong, nonatomic) ImagePicker *imagePicker;
@property (strong, nonatomic) NSMutableArray *uploadImageViewArray;
@end

@implementation PublishStep1ViewController

- (void)viewDidLoad {
    self.needKeyboardAssist = YES;
    [super viewDidLoad];
}

- (void)prepareData {
    //    _titleTextField.text = _params[@"title"];
    //    _summaryTextView.text = _params[@"summary"];
}

- (BOOL)fillData {
    //    _params[@"title"] = _titleTextField.text;
    //    _params[@"summary"] = _summaryTextView.text;
    return YES;
}

- (IBAction)addPicBtnClick:(id)sender {
    if ([_uploadImageViewArray count] >= 3) {
        [AppUtils showAlertView:@"" message:@"最多只能发表3张图片"];
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
    [delBtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
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

#pragma mark -

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
