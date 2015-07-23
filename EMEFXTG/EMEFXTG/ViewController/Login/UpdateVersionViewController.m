//
//  UpdateVersionViewController.m
//  EMESHT
//
//  Created by xuanhr on 14-11-17.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "UpdateVersionViewController.h"

@interface UpdateVersionViewController ()

@end

@implementation UpdateVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _versionNumber.text = [NSString stringWithFormat:@"%@ v%@版", _version.appName, _version.appVer];
    _descLabel.text = _version.appDesc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updataClick:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", _version.appUrl]]];
}
@end
