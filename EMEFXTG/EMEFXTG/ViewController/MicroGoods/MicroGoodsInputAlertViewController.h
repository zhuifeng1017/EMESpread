//
//  MicroGoodsInputAlertViewController.h
//  EMEFXTG
//
//  Created by apple on 15/6/23.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "EMEViewController.h"

@interface MicroGoodsInputAlertViewController : EMEViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (copy, nonatomic) EMEActionBlock actionBlock;
- (IBAction)insertBtnClick:(id)sender;
- (IBAction)cancelBtnClick:(id)sender;

@end
