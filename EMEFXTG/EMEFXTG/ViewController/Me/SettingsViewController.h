//
//  SettingsViewController.h
//  EMESHT
//
//  Created by ZhaoMin on 15/3/26.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *newestLabel;
@property (weak, nonatomic) IBOutlet UIButton *exitButton;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

- (IBAction)changePwdBtnClick:(id)sender;

- (IBAction)checkVersionBtnClick:(id)sender;

- (IBAction)techSupportBtnClick:(id)sender;

- (IBAction)exitBtnClick:(id)sender;

@end
