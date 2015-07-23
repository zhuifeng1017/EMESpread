//
//  ReleaseDoodsViewController.h
//  EMEFXTG
//
//  Created by Apple on 15/7/21.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IStepViewControllerDatasource.h"

@interface ReleaseGoodsViewController : UIViewController <IStepViewControllerDatasource>
@property (weak, nonatomic) IBOutlet UITextField *EMETitleTF;
@property (weak, nonatomic) IBOutlet UITextField *EMEPriceTF;
@property (weak, nonatomic) IBOutlet UITextField *EMENumberTF;
@property (weak, nonatomic) IBOutlet UITextField *EMEIntroductionTF;
@property(nonatomic)NSInteger num;
@property (weak, nonatomic) IBOutlet UIButton *startImageBtn;
- (IBAction)uploadImageClick:(id)sender;

@end
