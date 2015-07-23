//
//  ReleaseGoodsIntroViewController.h
//  EMEFXTG
//
//  Created by apple on 15/7/23.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
#import "EMEViewController.h"
#import "IStepViewControllerDatasource.h"
#import "EMEGridView.h"

@interface PublishStep1ViewController : EMEViewController <IStepViewControllerDatasource>
@property (weak, nonatomic) NSMutableDictionary *params;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *detailUrlTextView;

@property (weak, nonatomic) IBOutlet EMEGridView *picGirdView;

- (IBAction)addPicBtnClick:(id)sender;
@end
