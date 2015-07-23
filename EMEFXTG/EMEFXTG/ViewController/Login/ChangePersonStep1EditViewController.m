//
//  ChangePersonStep1EditViewController.m
//  EMESHT
//
//  Created by xuanhr on 14-11-19.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "ChangePersonStep1EditViewController.h"
#import "AppCacheManager.h"
#import "UIButton+WebCache.h"

@interface ChangePersonStep1EditViewController ()
@property (strong, nonatomic) ImagePickAndUploader *imagePickAndUploader;
@end

@implementation ChangePersonStep1EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureData];
    [self prepareData];
}

- (void)configureData {
    _imagePickAndUploader = [[ImagePickAndUploader alloc] init];
    _imagePickAndUploader.needCompress = YES;
    _imagePickAndUploader.aspectRatio = 1;
    _imagePickAndUploader.keepingCropAspectRatio = YES;
}

- (IBAction)uploadImageClick:(id)sender {
    [_imagePickAndUploader showPickDialog:self imageView:self.imageButton];
}

- (void)prepareData {
    //    if (_paramSupply.icon.length > 0) {
    //        [_imageButton sd_setImageWithURL:[NSURL URLWithString:_paramSupply.icon] forState:UIControlStateNormal];
    //    }
    NSString *tempIconName = [AppCacheManager sharedManager].loginUser.icon;
    if (tempIconName.length > 0) {
        [_imageButton sd_setImageWithURL:[NSURL URLWithString:tempIconName] forState:UIControlStateNormal];
    }
}

- (BOOL)fillData {
    if (_imagePickAndUploader.imageUploaderStatus == ImageUploaderStatusProcessing || _imagePickAndUploader.imageUploaderStatus == ImageUploaderStatusFail) {
        return NO;
    }

    if (_imagePickAndUploader.imageUploaderStatus == ImageUploaderStatusSucc) {
        //        _paramSupply.icon = _imagePickAndUploader.serverUrl;
        _paramUpdateInfoRequest.icon = _imagePickAndUploader.serverUrl;
    }

    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
