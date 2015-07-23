//
//  UpdateVersionViewController.h
//  EMESHT
//
//  Created by xuanhr on 14-11-17.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Version.h"

@interface UpdateVersionViewController : UIViewController
@property (strong, nonatomic) Version *version;
@property (weak, nonatomic) IBOutlet UILabel *versionNumber;
@property (weak, nonatomic) IBOutlet UILabel *fileSize;
@property (weak, nonatomic) IBOutlet UITextView *descLabel;
- (IBAction)updataClick:(id)sender;

@end
