
//
//  EMEViewController.m
//  EMEHS
//
//  Created by Mac on 14-8-30.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "EMEViewController2.h"
#import "BottomContactInfoViewController.h"
#import <objc/runtime.h>

@interface EMEViewController2 ()
@property (nonatomic, strong) BottomContactInfoViewController *bottomContactInfoViewController;
@end

@implementation EMEViewController2

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.needBottomContactInfo) {
        if (!_bottomContactInfoViewController) {
            _bottomContactInfoViewController = [[BottomContactInfoViewController alloc] initWithNibName:@"BottomContactInfoViewController" bundle:nil];
            [self addChildViewController:_bottomContactInfoViewController];

            [self.view addSubview:_bottomContactInfoViewController.view];
            _bottomContactInfoViewController.view.bottom = self.view.bottom;
        }
    }
}

@end
