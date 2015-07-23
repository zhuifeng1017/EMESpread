//
//  KeFuPopupViewController.h
//  EMESHT
//
//  Created by xuanhr on 14-11-17.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeFuPopupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UIView *innerBackGroundView;
@property (weak, nonatomic) IBOutlet UIButton *phoneNumberBtn;
- (IBAction)callKeFu:(id)sender;

@end
