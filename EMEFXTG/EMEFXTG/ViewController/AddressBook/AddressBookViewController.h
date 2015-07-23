//
//  AddressBookViewController.h
//  EMESHT
//
//  Created by xuanhr on 14-10-11.
//  Copyright (c) 2014年 eme. All rights reserved.
//
/**
 *
 *----------Dragon be here!----------/
 * 　　　┏┓　　　┏┓
 * 　　┏┛┻━━━┛┻┓
 * 　　┃　　　　　　　┃
 * 　　┃　　　━　　　┃
 * 　　┃　┳┛　┗┳　┃
 * 　　┃　　　　　　　┃
 * 　　┃　　　┻　　　┃
 * 　　┃　　　　　　　┃
 * 　　┗━┓　　　┏━┛
 * 　　　　┃　　　┃神兽保佑
 * 　　　　┃　　　┃代码无BUG！
 * 　　　　┃　　　┗━━━┓
 * 　　　　┃　　　　　　　┣┓
 * 　　　　┃　　　　　　　┏┛
 * 　　　　┗┓┓┏━┳┓┏┛
 * 　　　　　┃┫┫　┃┫┫
 * 　　　　　┗┻┛　┗┻┛
 * ━━━━━━神兽出没━━━━━━
 */
#import "EMEViewController.h"
#import "EMENavigationBar.h"
#import "RHAddressBook.h"
#import "Friend.h"
#import "AdressBookTableViewController.h"
#import "MALTabBarViewController.h"
#import "SVGloble.h"
#import "EMENavigationBarSht.h"

@protocol AddressBookSelectionDelegate <NSObject>
- (void)completeSelection:(NSArray *)selectionArray;
@end

@interface AddressBookViewController : EMEViewController <SVPositionDelegate>
@property (weak, nonatomic) IBOutlet EMENavigationBarSht *navigationBar;
@property (assign, nonatomic) BOOL isHideBack;
@property (assign, nonatomic) BOOL isMutableTouch;
@property (weak, nonatomic) IBOutlet SVGloble *globalScrollContainer;
@property (strong, nonatomic) NSMutableArray *friendArry;
@property (strong, nonatomic) NSMutableArray *addressBookArry;

@property (weak, nonatomic) IBOutlet UIButton *peopleIconBtn;
@property (weak, nonatomic) IBOutlet UIButton *editIconBtn;
@property (weak, nonatomic) IBOutlet UILabel *peopleName;
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (strong, nonatomic) AdressBookTableViewController *addressBookTableViewController;
@property (strong, nonatomic) AdressBookTableViewController *addressBookTableViewController2;
@property (weak, nonatomic) IBOutlet EMENavigationBar *navBar;
@property (strong, nonatomic) NSDictionary *dict;
@property (weak, nonatomic) id<AddressBookSelectionDelegate> selectionDelegate;
@property (nonatomic, weak) id<MALTabBarChinldVIewControllerDelegate> delegate;

- (IBAction)searchClick:(id)sender;
- (IBAction)addContact:(id)sender;
- (IBAction)peopleIconClick:(UIButton *)sender;

@end
