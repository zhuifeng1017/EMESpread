//
//  AppVersionPopViewController.h
//  EMEHS-MGT
//
//  Created by appeme on 14-9-19.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Version.h"

@interface AppVersionPopViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *appNameAndVersionLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *updateClick;
@property (strong, nonatomic) Version *version;
- (IBAction)updateClick:(id)sender;
@end
