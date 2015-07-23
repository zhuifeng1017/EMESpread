//
//  PublishManagerViewController.h
//  EMEFXTG
//
//  Created by appeme on 15/7/23.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMEViewController.h"
#import "SVGloble.h"
#import "StyledPageControl.h"

@interface PublishManagerViewController : EMEViewController
@property (assign, nonatomic) BOOL isNewPublish;
@property (strong, nonatomic) NSMutableDictionary *params;
@property (weak, nonatomic) IBOutlet SVGloble *globalScrollContainer;
@property (weak, nonatomic) IBOutlet StyledPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
- (IBAction)nextClick:(id)sender;
@end
