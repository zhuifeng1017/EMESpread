//
//  BottomContactInfoViewController.h
//  EMEHS-MGT
//
//  Created by appeme on 14-9-11.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMEViewController.h"

@interface BottomContactInfoViewController : EMEViewController
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneClick;
- (IBAction)helpClick:(id)sender;
- (IBAction)phoneClick:(id)sender;

@end
