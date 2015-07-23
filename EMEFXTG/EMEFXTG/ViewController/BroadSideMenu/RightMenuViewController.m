//
//  RightMenuViewController.m
//  EMEFXTG
//
//  Created by appeme on 15/7/22.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "RightMenuViewController.h"
#import "AppUtils.h"
#import "PublishManagerViewController.h"
#import "SlideNavigationController.h"

@interface RightMenuViewController ()

@end

@implementation RightMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 1) {
        PublishManagerViewController *vc = [[PublishManagerViewController alloc] init];
        vc.isNewPublish = YES;
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc withSlideOutAnimation:NO andCompletion:nil];
    } else {
        [AppUtils showAlertView:@"" message:@"'产品众筹'功能正在拼命开发中..."];
    }
}
@end
