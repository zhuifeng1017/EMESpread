//
//  KeFuPopupViewController.m
//  EMESHT
//
//  Created by xuanhr on 14-11-17.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "KeFuPopupViewController.h"

@interface KeFuPopupViewController ()

@end

@implementation KeFuPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _backGroundView.backgroundColor = [UIColor colorWithHexString:@"33000000"];
    _backGroundView.layer.cornerRadius = 10;
    _innerBackGroundView.layer.cornerRadius = 8;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callKeFu:(id)sender {
    [self.view webCallPhone:_phoneNumberBtn.titleLabel.text];
}
@end
