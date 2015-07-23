//
//  ChooseLoginOrRegisterPopUpViewController.h
//  EMESHT
//
//  Created by xuanhr on 14/12/25.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseLoginOrRegisterPopUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UIView *innerBackGroundView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
- (IBAction)loginClick:(id)sender;
- (IBAction)registerBtn:(id)sender;

@end
