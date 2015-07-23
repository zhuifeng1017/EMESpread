//
//  BasePopViewController.h
//  EMEFXTG
//
//  Created by appeme on 15/7/23.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasePopViewController : UIViewController
@property (readonly, strong, nonatomic) UIView *customView;
- (instancetype)initWithCustomView:(UIView *)customView;
- (instancetype)initWithCustomXib:(NSString *)customXib;
- (UIView *)showPopOn:(UIViewController *)viewController withBackgroundColor:(UIColor *)backgroundColor;
- (void)dismiss:(BOOL)animated;
@end
