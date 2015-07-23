//
//  AdressBookTableViewController.h
//  EMESHT
//
//  Created by xuanhr on 14-10-17.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressBookInfo.h"

@interface AdressBookTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *addressBookInfoArray; //AddressBookInfo[]
@property (assign, nonatomic) BOOL tableViewCanMultipeTouch;
@property (assign, nonatomic) BOOL isAddressBook;
- (NSArray *)getSelection; //Login[]
@end

@interface AddressBookCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIImageView *isFriendImage;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property BOOL isSelect;
@end

