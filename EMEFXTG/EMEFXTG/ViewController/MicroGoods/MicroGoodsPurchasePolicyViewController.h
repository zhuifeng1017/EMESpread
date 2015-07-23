//
//  MicroGoodsPurchasePolicyViewController.h
//  EMEFXTG
//
//  Created by appeme on 15/6/11.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMEViewController.h"
#import "StackPanel.h"

@interface MicroGoodsPurchasePolicyViewController : EMEViewController
@property (weak, nonatomic) IBOutlet UILabel *originPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIView *container1;
@property (weak, nonatomic) IBOutlet UIView *container2;
@property (weak, nonatomic) IBOutlet UIView *container3;
@property (weak, nonatomic) IBOutlet UIView *rootContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *container2ScrollView;
@property (weak, nonatomic) IBOutlet StackPanel *container2StackPanel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
- (IBAction)addPolicyClick:(id)sender;
- (IBAction)submitClick:(id)sender;
- (IBAction)pickDateClick:(id)sender;
@end

#pragma mark - MicroGoodsPolicyEditCell
@interface MicroGoodsPolicyEditCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *peopleCountTextField;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UITextField *saveTextField;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@end

@interface MicroGoodsPolicyInfo : NSObject
@property (strong, nonatomic) NSNumber *peopleCount;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSNumber *save;
@end

