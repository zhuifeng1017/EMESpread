//
//  MicroGoodsForwardRedPacketsViewController.m
//  EMEFXTG
//
//  Created by apple on 15/6/12.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "MicroGoodsForwardRedPacketsViewController.h"

@interface MicroGoodsForwardRedPacketsViewController ()

@end

@implementation MicroGoodsForwardRedPacketsViewController

- (void)viewDidLoad {
    self.needKeyboardAssist = YES;
    [super viewDidLoad];
    _redPacketBtn1.selected = YES;
    _redPacketBtn2.selected = NO;
}

- (IBAction)redPacketBtn1Click:(UIButton *)sender {
    _redPacketBtn1.selected = YES;
    _redPacketBtn2.selected = NO;
}

- (IBAction)redPacketBtn2Click:(UIButton *)sender {
    _redPacketBtn2.selected = YES;
    _redPacketBtn1.selected = NO;
}
@end
