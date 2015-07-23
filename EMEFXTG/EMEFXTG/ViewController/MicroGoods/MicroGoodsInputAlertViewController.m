//
//  MicroGoodsInputAlertViewController.m
//  EMEFXTG
//
//  Created by apple on 15/6/23.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "MicroGoodsInputAlertViewController.h"

@interface MicroGoodsInputAlertViewController ()

@end

@implementation MicroGoodsInputAlertViewController

- (void)viewDidLoad {
    self.needKeyboardAssist = YES;
    [super viewDidLoad];
}


- (IBAction)insertBtnClick:(id)sender {
    if (self.actionBlock) {
        self.actionBlock(@"insert", self, self.textField.text);
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    if (self.actionBlock) {
        self.actionBlock(@"dismiss", self, nil);
    }
}

- (IBAction)cancelBtnClick:(id)sender {
    if (self.actionBlock) {
        self.actionBlock(@"dismiss", self, nil);
    }
}
@end
