//
//  MicroGoodsForwardRedPacketsViewController.h
//  EMEFXTG
//
//  Created by apple on 15/6/12.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMEViewController.h"

@interface MicroGoodsForwardRedPacketsViewController : EMEViewController
@property (weak, nonatomic) IBOutlet UIButton *redPacketBtn1;
@property (weak, nonatomic) IBOutlet UIButton *redPacketBtn2;
- (IBAction)redPacketBtn1Click:(UIButton *)sender;
- (IBAction)redPacketBtn2Click:(UIButton *)sender;

@end
