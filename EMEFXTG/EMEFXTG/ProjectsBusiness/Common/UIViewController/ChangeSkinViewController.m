//
//  ChangeSkinViewController.m
//  EMEHS
//
//  Created by xuanhr on 14-8-14.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "ChangeSkinViewController.h"
#import "EMENavigationBar.h"
#import "UIView+AnimationExtensions.h"
#import "EMEThemeManager.h"

@interface ChangeSkinViewController ()

@end

@implementation ChangeSkinViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor colorWithWhite:0 alpha:.3]];
    UITapGestureRecognizer *tapTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelf)];
    tapTouch.delegate = self;
    [self.view addGestureRecognizer:tapTouch];

    [self.paletteView animationForPopupFromBottom:nil];

    NSString *currentTheme = [[EMEThemeManager sharedManager] currentThemeName];
    if (!currentTheme || [currentTheme isEqual:@"default"]) {
        currentTheme = @"1";
    }

    int index = [currentTheme intValue];
    if (index > 0 && index <= [[self.paletteView subviews] count]) {
        [[self.paletteView subviews][index - 1] pulseToSize:1.08f duration:0.3f repeat:YES];
    }
}

- (void)removeSelf {
    [self.paletteView animationForPopupBackToBottom:^{
        [self.view removeFromSuperview];
    }];
}

- (void)attachToWindow {
    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    self.view.bottom = [UIApplication sharedApplication].keyWindow.bottom;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 输出点击的view的类名
    NSLog_d(@"%@", NSStringFromClass([touch.view class]));
    if ([touch.view isKindOfClass:[UIButton class]]) {
        [[EMEThemeManager sharedManager] changeTheme:[NSString stringWithFormat:@"0%d", touch.view.tag]];
        for (UIView *childView in [_paletteView subviews]) {
            if ([childView isKindOfClass:[UIButton class]]) {
                [childView stopAnimation];
            }
        }
        [touch.view pulseToSize:1.08f duration:0.3f repeat:YES];
        return YES;
    }
    if (touch.view != self.view) {
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
