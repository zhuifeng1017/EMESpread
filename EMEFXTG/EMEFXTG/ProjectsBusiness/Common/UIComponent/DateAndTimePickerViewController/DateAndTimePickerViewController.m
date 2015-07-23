/*
 
BKDateAndTimePickerView 
 
 The MIT License (MIT)
 
 Copyright (c) 2014 Bhavya Kothari
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "DateAndTimePickerViewController.h"
#import "EMEPopViewController.h"

#define currentMonth [currentMonthString integerValue]

@interface DateAndTimePickerViewController () <UIPickerViewDelegate>

#pragma mark - IBActions

@property (weak, nonatomic) IBOutlet UITextField *textFieldEnterDate;

@end

@implementation DateAndTimePickerViewController {

    NSArray *yearArray;
    NSArray *monthArray;
    NSArray *daysArray;
    NSArray *amPmArray;
    NSArray *hoursArray;
    NSArray *minutesArray;

    NSString *currentMonthString;

    int selectedYearRow;
    int selectedMonthRow;
    int selectedDayRow;

    BOOL firstTimeLoad;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    firstTimeLoad = YES;

    self.customPicker.delegate = self;

    NSDate *date;
    if (_timeDate == nil) {
        date = [NSDate date];
    } else {
        date = _timeDate;
    }

    // Get Current Year

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];

    NSString *currentyearString = [NSString stringWithFormat:@"%@",
                                                             [formatter stringFromDate:date]];

    // Get Current  Month

    [formatter setDateFormat:@"MM"];

    currentMonthString = [NSString stringWithFormat:@"%d", [[formatter stringFromDate:date] integerValue]];

    // Get Current  Date

    [formatter setDateFormat:@"dd"];
    NSString *currentDateString = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];

    // Get Current  Hour
    [formatter setDateFormat:@"HH"];
    NSString *currentHourString = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];

    // Get Current  Minutes
    [formatter setDateFormat:@"mm"];
    NSString *currentMinutesString = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];

    // Get Current  AM PM

    [formatter setDateFormat:@"a"];
    NSString *currentTimeAMPMString = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];

    // PickerView -  Years data

    NSMutableArray *tmpYearArray = [[NSMutableArray alloc] init];

    for (int i = 1970; i <= 2050; i++) {
        [tmpYearArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
    yearArray = [tmpYearArray copy];

    // PickerView -  Months data

    monthArray = @[ @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12" ];

    // PickerView -  Hours data

    hoursArray = @[ @"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", ];

    // PickerView -  Hours data

    NSMutableArray *tmpMinutesArray = [[NSMutableArray alloc] init];

    for (int i = 0; i < 60; i++) {

        [tmpMinutesArray addObject:[NSString stringWithFormat:@"%02d", i]];
    }
    minutesArray = [tmpMinutesArray copy];

    // PickerView -  AM PM data

    amPmArray = @[ @"AM", @"PM" ];

    // PickerView -  days data

    NSMutableArray *tmpDaysArray = [[NSMutableArray alloc] init];

    for (int i = 1; i <= 31; i++) {
        [tmpDaysArray addObject:[NSString stringWithFormat:@"%02d", i]];
    }
    daysArray = [tmpDaysArray copy];

    // PickerView - Default Selection as per current Date

    [self.customPicker selectRow:[yearArray indexOfObject:currentyearString] inComponent:0 animated:YES];

    [self.customPicker selectRow:[monthArray indexOfObject:currentMonthString] inComponent:1 animated:YES];

    [self.customPicker selectRow:[daysArray indexOfObject:currentDateString] inComponent:2 animated:YES];

    [self.customPicker selectRow:[hoursArray indexOfObject:currentHourString] inComponent:3 animated:YES];

    [self.customPicker selectRow:[minutesArray indexOfObject:currentMinutesString] inComponent:4 animated:YES];

    //    [self.customPicker selectRow:[amPmArray indexOfObject:currentTimeAMPMString] inComponent:5 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    if (component == 0) {
        selectedYearRow = row;
        [self.customPicker reloadAllComponents];
    } else if (component == 1) {
        selectedMonthRow = row;
        currentMonthString = [NSString stringWithFormat:@"%d", row + 1];
        [self.customPicker reloadAllComponents];
    } else if (component == 2) {
        selectedDayRow = row;

        [self.customPicker reloadAllComponents];
    }
}

#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {

    // Custom View created for each component

    UILabel *pickerLabel = (UILabel *)view;

    if (!pickerLabel) {
        CGRect frame = CGRectMake(0.0, 0.0, 50, 60);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15.0f]];

        if (component == 0) {
            pickerLabel.text = [yearArray objectAtIndex:row]; // Year
        } else if (component == 1) {
            pickerLabel.text = [monthArray objectAtIndex:row]; // Month
        } else if (component == 2) {
            pickerLabel.text = [daysArray objectAtIndex:row]; // Date

        } else if (component == 3) {
            pickerLabel.text = [hoursArray objectAtIndex:row]; // Hours
        } else if (component == 4) {
            pickerLabel.text = [minutesArray objectAtIndex:row]; // Mins
        } else {
            pickerLabel.text = [amPmArray objectAtIndex:row]; // AM/PM
        }
    }

    return pickerLabel;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 5;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    if (component == 0) {
        return [yearArray count];

    } else if (component == 1) {
        return [monthArray count];
    } else if (component == 2) { // day

        if (firstTimeLoad) {
            if (currentMonth == 1 || currentMonth == 3 || currentMonth == 5 || currentMonth == 7 || currentMonth == 8 || currentMonth == 10 || currentMonth == 12) {
                return 31;
            } else if (currentMonth == 2) {
                int yearint = [[yearArray objectAtIndex:selectedYearRow] intValue];

                if (((yearint % 4 == 0) && (yearint % 100 != 0)) || (yearint % 400 == 0)) {

                    return 29;
                } else {
                    return 28; // or return 29
                }

            } else {
                return 30;
            }

        } else {

            if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11) {
                return 31;
            } else if (selectedMonthRow == 1) {
                int yearint = [[yearArray objectAtIndex:selectedYearRow] intValue];

                if (((yearint % 4 == 0) && (yearint % 100 != 0)) || (yearint % 400 == 0)) {
                    return 29;
                } else {
                    return 28; // or return 29
                }

            } else {
                return 30;
            }
        }

    } else if (component == 3) { // hour

        return 24;

    } else if (component == 4) { // min
        return 60;
    } else { // am/pm
        return 2;
    }
}

- (IBAction)actionCancel:(id)sender {

    //    [UIView animateWithDuration:0.3
    //        delay:0
    //        options:UIViewAnimationOptionCurveEaseIn
    //        animations:^{
    //
    //            //             self.customPicker.alpha = 0;
    //            //             self.toolbarCancelDone.hidden = YES;
    //        }
    //        completion:^(BOOL finished) {
    //            self.customPicker.hidden = YES;
    //            self.customPicker.alpha = 1;
    //            self.toolbarCancelDone.hidden = YES;
    //        }];
    [(id)self.parentViewController dismiss];
}

- (IBAction)actionDone:(id)sender {
    int addingHour = 0; //[self.customPicker selectedRowInComponent:5] * 12;
    int hour = [[hoursArray objectAtIndex:[self.customPicker selectedRowInComponent:3]] intValue] + addingHour;

    NSString *tempString = [NSString stringWithFormat:@"%@-%@-%@ %d:%@", [yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]], [monthArray objectAtIndex:[self.customPicker selectedRowInComponent:1]], [daysArray objectAtIndex:[self.customPicker selectedRowInComponent:2]], hour, [minutesArray objectAtIndex:[self.customPicker selectedRowInComponent:4]]];
    //    self.textFieldEnterDate.text = [NSString stringWithFormat:@"%@-%@-%@ %d:%@", [yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]], [monthArray objectAtIndex:[self.customPicker selectedRowInComponent:1]], [DaysArray objectAtIndex:[self.customPicker selectedRowInComponent:2]], hour, [minutesArray objectAtIndex:[self.customPicker selectedRowInComponent:4]]];

    NSDate *selectedDate = [NSDate dateFromString:@"yyyy-MM-dd HH:mm" dateString:tempString];
    if (_delegate) {
        [_delegate selectedDatetime:selectedDate];
    }

    [(id)self.parentViewController dismiss];

    NSLog(@"------  %@", [selectedDate formattedDateWithDefaultFormat]);
}

@end
