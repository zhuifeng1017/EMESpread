//
//  MicroGoodsPopDetailViewController.m
//  EMEFXTG
//
//  Created by appeme on 15/6/12.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "MicroGoodsPopDetailViewController.h"
#import "EMEPopViewController.h"

@interface MicroGoodsPopDetailViewController ()

@end

@implementation MicroGoodsPopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)closeClick:(id)sender {
    [(EMEPopViewController *)self.parentViewController dismiss];
}
@end
