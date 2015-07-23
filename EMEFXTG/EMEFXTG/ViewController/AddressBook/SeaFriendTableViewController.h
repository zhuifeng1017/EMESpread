//
//  SeaFriendTableViewController.h
//  EMESHT
//
//  Created by xuanhr on 15/2/11.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"

@class User;

@interface SeaFriendTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) User *user;

@property (strong, nonatomic) UIView *viewHeader;
@property (assign, nonatomic) int viewHeaderHeight;
@property (assign, nonatomic) BOOL justShowFriend;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UIView *searchBGView;
@property (weak, nonatomic) IBOutlet UIView *searchView;


- (IBAction)searchClick:(UIButton *)sender;

@end

/**
 *  SeaFriendCell
 */
@interface SeaFriendCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *companyName;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *peopleIcon;

@property (weak, nonatomic) IBOutlet UIButton *addFriendBtn;

@property (weak, nonatomic) IBOutlet UILabel *friendLabel;

@end