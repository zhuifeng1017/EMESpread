//
//  MicroGoodsPurchasePolicyViewController.m
//  EMEFXTG
//
//  Created by appeme on 15/6/11.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "MicroGoodsPurchasePolicyViewController.h"
#import "DateAndTimePickerViewController.h"
#import "EMEPopViewController.h"

@interface MicroGoodsPurchasePolicyViewController () <DateAndTimePickerDelegate>
@property (strong, nonatomic) NSMutableArray *policyInfoArray;
@property (strong, nonatomic) NSDate *endDate;
@end

@implementation MicroGoodsPurchasePolicyViewController

static NSString *cellIdentifier = @"cellIdentifier";

- (void)viewDidLoad
{
    self.needKeyboardAssist = YES;
    [super viewDidLoad];

    self.title = @"添加反向团购策略";
    
    _endDate = [NSDate date];
    [self selectedDatetime:_endDate];
    
    [self loadPolicyInfos];
}

- (void)refreshTableViewLayout {
    _container2StackPanel.height = 48 * _container2StackPanel.subviews.count;
    
    _container2ScrollView.height = fmin(_container2StackPanel.height, _rootContainer.height - _container1.height - _container3.height - _container2ScrollView.top);
    _container2.height = _container2ScrollView.bottom;
}

- (void)loadPolicyInfos {
    MicroGoodsPolicyInfo *info = [[MicroGoodsPolicyInfo alloc] init];
    info.peopleCount = @(1);
    info.price = @(2);
    info.save = @(3);
    
//    _policyInfoArray = [@[info, info] mutableCopy];
    
    for (int i=0; i<_policyInfoArray.count; i++) {
        [self addPolicyClick:nil];
        
        MicroGoodsPolicyEditCell *cell = (MicroGoodsPolicyEditCell *)_container2StackPanel.subviews[i];
        cell.peopleCountTextField.text = [NSString stringWithFormat:@"%d", info.peopleCount ? [info.peopleCount intValue] : 0];
        cell.moneyTextField.text = [NSString stringWithFormat:@"%d", info.peopleCount ? [info.price intValue] : 0];
        cell.saveTextField.text = [NSString stringWithFormat:@"%d", info.peopleCount ? [info.save intValue] : 0];
    }
    
    if (_policyInfoArray.count == 0) {
        [self addPolicyClick:nil];
    }
    
    self.needKeyboardAssist = YES;
}

- (void)showDatePickerWithTimeDate:(NSDate *)timeDate {
    DateAndTimePickerViewController *datePickerViewController = [[DateAndTimePickerViewController alloc] initWithNibName:@"DateAndTimePickerViewController" bundle:nil];
    datePickerViewController.delegate = self;
    datePickerViewController.timeDate = timeDate;
    EMEPopViewController *emePopupViewController = [[EMEPopViewController alloc] initWithRootViewController:datePickerViewController];
    [self.navigationController pushViewController:emePopupViewController animated:YES popStyle:EMEPopStyleFromBottom];
}

- (void)selectedDatetime:(NSDate *)date {
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    
    self.dateLabel.text = [date formattedDateWithFormat:@"yyyy年MM月dd日 HH:mm" timeZone:[NSTimeZone localTimeZone] locale:locale];
    _endDate = date;
}

#pragma mark - Add Cell

- (IBAction)addPolicyClick:(id)sender {
    MicroGoodsPolicyEditCell *cell = (MicroGoodsPolicyEditCell *)[[NSBundle mainBundle] loadNibNamed:@"MicroGoodsPolicyEditCell" owner:self options:nil][0];
    [_container2StackPanel addSubview:cell];
    [self refreshStackPanel];
    
    [cell.actionButton addTarget:self action:@selector(deleteCellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.needKeyboardAssist = YES;
    
    int top = _container2StackPanel.height > _container2ScrollView.height ? _container2StackPanel.height - _container2ScrollView.height : 0;
    _container2ScrollView.contentOffset = CGPointMake(0, top);
}

- (IBAction)pickDateClick:(id)sender {
    [self showDatePickerWithTimeDate:_endDate];
}

- (IBAction)submitClick:(id)sender {
    _policyInfoArray = [NSMutableArray array];
    
    for (int i=0; i<_container2StackPanel.subviews.count; i++) {
        MicroGoodsPolicyEditCell *cell  = (MicroGoodsPolicyEditCell *)_container2StackPanel.subviews[i];
        
        MicroGoodsPolicyInfo *info = [[MicroGoodsPolicyInfo alloc] init];
        info.peopleCount = @([cell.peopleCountTextField.text intValue]);
        info.price = @([cell.moneyTextField.text intValue]);
        info.save = @([cell.saveTextField.text intValue]);
        
        [_policyInfoArray addObject:info];
    }
    
    NSLog(@"%@", _policyInfoArray);
}

- (void)deleteCellClick:(id)sender {
    [self hideKeyboard];
    [[((UIView *)sender) getParentKindOfClazz:[MicroGoodsPolicyEditCell class]] removeFromSuperview];
    
    [self refreshStackPanel];
}


- (void)refreshStackPanel {
    _container2StackPanel.height = _container2StackPanel.subviews.count * 48;
    _container2ScrollView.contentSize = CGSizeMake(320, _container2StackPanel.height);
    
    [self refreshTableViewLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


#pragma mark - MicroGoodsPolicyEditCell
@implementation MicroGoodsPolicyEditCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


#pragma mark - MicroGoodsPolicyInfo
@implementation MicroGoodsPolicyInfo
@end

