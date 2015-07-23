//
//  ChooseBusinessViewController.h
//  EMESHT
//
//  Created by xuanhr on 14-10-31.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "EMEPopViewController.h"

typedef void (^ChoosePopViewSingleSelectionBlock)(int selectedIndex);
typedef void (^ChoosePopViewMutliSelectionBlock)(NSArray *selectedIndexs);

@interface ChoosePopViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
//input parameter
@property (copy, nonatomic) NSString *titleText;
@property (copy, nonatomic) NSString *saveButtonText;
@property (assign, nonatomic) BOOL multiSelection;
@property (strong, nonatomic) NSArray *displayTextArray;
@property (assign, nonatomic) NSInteger selectedIndex;            // single selection
@property (strong, nonatomic) NSMutableArray *selectedIndexArray; // multi selection
//common parameter
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *saveClickButton;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
- (void)setChoosePopViewSingleSelectionBlock:(ChoosePopViewSingleSelectionBlock)block;
- (void)setChoosePopViewMutliSelectionBlock:(ChoosePopViewMutliSelectionBlock)block;
- (IBAction)saveClick:(id)sender;
@end

@interface ChoosePopViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chooseImage;

@end