//
//  ReleaseGoodsDetailViewController.h
//  EMEFXTG
//
//  Created by apple on 15/7/23.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
#import "EMEViewController.h"
#import "IStepViewControllerDatasource.h"
#import "EMENavigationBar.h"

@interface PublishStep2ViewController : EMEViewController <IStepViewControllerDatasource>
@property (weak, nonatomic) NSMutableDictionary *params;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *contentTextView;
@property (weak, nonatomic) IBOutlet EMENavigationBar *navBar;
@end
 