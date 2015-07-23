//
//  BasePopViewController.m
//  EMEFXTG
//
//  Created by appeme on 15/7/23.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "BasePopViewController.h"
#import "EMEPopViewController.h"

@interface BasePopViewController ()
@property (strong, nonatomic) EMEPopViewController *emePopupViewController;
@end

@implementation BasePopViewController

- (instancetype)initWithCustomView:(UIView *)customView {
    self = [self init];
    if (self) {
        _customView = customView;
    }
    return self;
}

- (instancetype)initWithCustomXib:(NSString *)customXib {
    self = [self init];
    if (self) {
        _customView = [[NSBundle mainBundle] loadNibNamed:customXib owner:self options:nil][0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *closeButton = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    closeButton.backgroundColor = [UIColor clearColor];
    [closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];

    _customView.bottom = self.view.bottom;
    [self.view addSubview:_customView];
}

- (UIView *)showPopOn:(UIViewController *)viewController withBackgroundColor:(UIColor *)backgroundColor {
    _emePopupViewController = [[EMEPopViewController alloc] initWithRootViewController:self];
    [viewController pushViewController:_emePopupViewController animated:YES popStyle:EMEPopStyleFromBottom];
    _emePopupViewController.view.backgroundColor = backgroundColor;

    return _customView;
}

- (void)dismiss {
    [_emePopupViewController dismiss];
}

- (void)dismiss:(BOOL)animated {
    _emePopupViewController.animated = animated;
    [_emePopupViewController dismiss];
}

@end
