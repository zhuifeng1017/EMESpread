//
//  ChangePersonStep1EditViewController.h
//  EMESHT
//
//  Created by xuanhr on 14-11-19.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePickAndUploader.h"
#import "User.h"
#import "Login.h"
#import "IStepViewControllerDatasource.h"

@interface ChangePersonStep1EditViewController : UIViewController
@property (weak, nonatomic) UpdateInfoRequest *paramUpdateInfoRequest;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
- (IBAction)uploadImageClick:(id)sender;
@end
