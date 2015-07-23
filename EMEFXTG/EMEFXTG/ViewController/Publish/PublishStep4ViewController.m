
//
//  PublishStep4ViewController.m
//  EMEFXTG
//
//  Created by appeme on 15/7/23.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "PublishStep4ViewController.h"
#import "ChoosePopViewController.h"
#import "AppUtils.h"

@interface PublishStep4ViewController ()
@property (copy, nonatomic) NSString *errorMessage;
@property (copy, nonatomic) NSArray *payModes;
@property (assign, nonatomic) int payModeIndex;
@end

@implementation PublishStep4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.payModes = @[@"拼手气", @"等额"];
    [AppUtils setLeftTextMargin:_payAccountTextField withLeftMargin:10];
    [AppUtils setLeftTextMargin:_payCountTextField withLeftMargin:10];
    
    [self prepareData];
}

- (void)prepareData
{
    _payAccountTextField.text = _params[@"payAccount"];
    _payCountTextField.text = _params[@"payCount"];
}

- (BOOL)fillData
{
    _params[@"payAccount"] = _payAccountTextField.text ?: [NSNull null];
    _params[@"payCount"] = _payCountTextField.text ?: [NSNull null];
    
    return YES;
}

- (IBAction)choosePayModeClick:(id)sender {
    [(EMEViewController *)self.parentViewController hideKeyboard];
    
    ChoosePopViewController *choosePopViewController = [[ChoosePopViewController alloc] initWithNibName:@"ChoosePopViewController" bundle:nil];
    choosePopViewController.titleText = @"选择红包方式";
    choosePopViewController.displayTextArray = _payModes;
    choosePopViewController.selectedIndex = _payModeIndex;
    EMEPopViewController *popupViewController = [[EMEPopViewController alloc] initWithRootViewController:choosePopViewController];
    [self.parentViewController pushViewController:popupViewController animated:YES popStyle:EMEPopStyleFromBottom];
    choosePopViewController.backgroundView.backgroundColor = [UIColor colorWithHexString:@"1FC494"];
    
    typeof(self) __weak weakSelf = self;
    
    [choosePopViewController setChoosePopViewSingleSelectionBlock:^(int selectedIndex) {
        
        if (selectedIndex >= 0) {
            weakSelf.payModeIndex = selectedIndex;
            weakSelf.payType.text = weakSelf.payModes[selectedIndex];
        }
    }];

}
@end
