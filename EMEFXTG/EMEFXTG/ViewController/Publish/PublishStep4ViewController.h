//
//  PublishStep4ViewController.h
//  EMEFXTG
//
//  Created by appeme on 15/7/23.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IStepViewControllerDatasource.h"
#import "EMEViewController.h"

@interface PublishStep4ViewController : EMEViewController <IStepViewControllerDatasource>
@property (weak, nonatomic) NSMutableDictionary *params;
@property (weak, nonatomic) IBOutlet UITextField *payAccountTextField;
@property (weak, nonatomic) IBOutlet UITextField *payCountTextField;
@property (weak, nonatomic) IBOutlet UILabel *payType;
- (IBAction)choosePayModeClick:(id)sender;
@end
