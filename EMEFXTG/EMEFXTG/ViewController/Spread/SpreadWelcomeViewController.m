//
//  SpreadWelcomeViewController.m
//  EMEFXTG
//
//  Created by apple on 15/7/22.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "SpreadWelcomeViewController.h"

@interface SpreadWelcomeViewController ()

@end

@implementation SpreadWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *contentArray = @[ @"传播正能量信息，打造优质，诚信，互助的品质生活", @"把优质商品告诉真正需要的朋友，您将收货一份答谢", @"把一份轻松传递给您的朋友，幸福回传给您" ];
    for (int i = 0; i < contentArray.count; ++i) {
        UIView *view = [self createItemView:contentArray[i]];
        [_scrollView addSubview:view];
        view.frame = CGRectMake(i * _scrollView.width, 0, _scrollView.width, _scrollView.height);

        if (i == (contentArray.count - 1)) {
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
            btn.frame = CGRectMake(250, 400, 60, 40);
            [btn setTitle:@"点击进入" forState:(UIControlStateNormal)];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [view addSubview:btn];
        }
    }
    _scrollView.contentSize = CGSizeMake(_scrollView.width * contentArray.count, _scrollView.height);
}

- (IBAction)btnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (UIView *)createItemView:(NSString *)contentText {
    UIView *view = [[UIView alloc] initWithFrame:(CGRect) {0, 0, _scrollView.width, _scrollView.height}];
    view.backgroundColor = [UIColor blackColor];
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRect) {0, 0, _scrollView.width, 300}];
    [view addSubview:label];
    label.center = view.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = contentText;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:24.0f];
    label.textColor = [UIColor whiteColor];
    return view;
}

@end
