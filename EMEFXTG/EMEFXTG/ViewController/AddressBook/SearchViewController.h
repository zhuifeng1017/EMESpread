//
//  SearchViewController.h
//  EMESHT
//
//  Created by xuanhr on 14-10-23.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMEViewController.h"
#import "User.h"

@interface SearchViewController : EMEViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate>
@property (strong, nonatomic) NSDictionary *dict;
@property (strong, nonatomic) NSArray *dataArry;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, retain) NSMutableDictionary *contactDic;
@property (nonatomic, retain) NSMutableArray *searchByName;
@property (nonatomic, retain) NSMutableArray *searchByPhone;
- (IBAction)chooseClick:(id)sender;
- (IBAction)searchClick:(id)sender;

@end
