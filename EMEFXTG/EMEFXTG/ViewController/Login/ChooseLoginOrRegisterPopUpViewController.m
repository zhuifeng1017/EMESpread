//
//  ChooseLoginOrRegisterPopUpViewController.m
//  EMESHT
//
//  Created by xuanhr on 14/12/25.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "ChooseLoginOrRegisterPopUpViewController.h"
#import "EMEPopViewController.h"

@interface ChooseLoginOrRegisterPopUpViewController ()

@end

@implementation ChooseLoginOrRegisterPopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _backGroundView.backgroundColor = [UIColor colorWithHexString:@"33000000"];
    _backGroundView.layer.cornerRadius = 10;
    _innerBackGroundView.layer.cornerRadius = 8;
    _loginBtn.layer.cornerRadius = 6;
    _registerBtn.layer.cornerRadius = 6;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClick:(id)sender {
    [(id)self.parentViewController dismiss];
}

- (IBAction)registerBtn:(id)sender {
//    RegisterViewController *registerViewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
//    [self.navigationController pushViewController:registerViewController animated:YES];
//    [(id)self.parentViewController dismiss];
}
@end
