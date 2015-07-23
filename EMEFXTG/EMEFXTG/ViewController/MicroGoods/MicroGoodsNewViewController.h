//
//  MicroGoodsNewViewController.h
//  EMEFXTG
//
//  Created by apple on 15/6/12.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackPanel.h"
#import "EMEGridView.h"
#import "EMEViewController.h"
#import "MALTabBarChinldVIewControllerDelegate.h"

@interface MicroGoodsNewViewController : EMEViewController
@property (nonatomic, weak) id<MALTabBarChinldVIewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *operateView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet StackPanel *stackPanel;

@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIView *priceView;
@property (weak, nonatomic) IBOutlet UIView *typeView;
@property (weak, nonatomic) IBOutlet UIView *mainPicView;
@property (weak, nonatomic) IBOutlet UIView *forwardView;
@property (weak, nonatomic) IBOutlet UIView *strategyView;
@property (weak, nonatomic) IBOutlet EMEGridView *picGirdView;
@property (weak, nonatomic) IBOutlet UIView *detailView;

@end
