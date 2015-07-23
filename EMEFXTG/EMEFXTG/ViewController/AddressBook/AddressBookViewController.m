//
//  AddressBookViewController.m
//  EMESHT
//
//  Created by xuanhr on 14-10-11.
//  Copyright (c) 2014年 eme. All rights reserved.
//
//
//                       _oo0oo_
//                      o8888888o
//                      88" . "88
//                      (| -_- |)
//                      0\  =  /0
//                    ___/`---'\___
//                  .' \\|     |// '.
//                 / \\|||  :  |||// \
//                / _||||| -:- |||||- \
//               |   | \\\  -  /// |   |
//               | \_|  ''\---/''  |_/ |
//               \  .-\__  '-'  ___/-. /
//             ___'. .'  /--.--\  `. .'___
//          ."" '<  `.___\_<|>_/___.' >' "".
//         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
//         \  \ `_.   \_ __\ /__ _/   .-` /  /
//     =====`-.____`.___ \_____/___.-`___.-'=====
//                       `=---='
//
//
//     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//               佛祖保佑         永无BUG
//

#import "AddressBookViewController.h"
#import "SearchViewController.h"
#import "RHPerson.h"
#import "ChineseToPinyin.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
//#import "ModifyUserInfoViewController.h"
#import "MoreViewController.h"
#import "SeaFriendTableViewController.h"

@interface AddressBookViewController () <UIAlertViewDelegate>
@property EMEHttpRequest *emeGetFriendListHttpRequest;
@property (assign, nonatomic) BOOL isReadABAdressBook;
@property (strong, nonatomic) UIAlertView *alertView;
@property (strong, nonatomic) SeaFriendTableViewController *seaFriendTableViewController;
@end

@implementation AddressBookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.needKeyboardAssist = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    }
    //    if ([[AppCacheManager sharedManager].loginUser.icon hasPrefix:@"http"]) {
    //        [self.peopleIconBtn sd_setImageWithURL:[NSURL URLWithString:[AppCacheManager sharedManager].loginUser.icon] forState:UIControlStateNormal];
    //        self.peopleName.text = [AppCacheManager sharedManager].loginUser.name;
    //        self.peopleName.width = 162;
    //        self.peopleName.left = _peopleIconBtn.right + 10;
    //    } else {
    //        self.peopleName.text = @"欢迎来到商海通APP";
    //        [self.peopleName sizeToFit];
    //        self.peopleName.left = _peopleIconBtn.right + 10;
    //        [self.peopleIconBtn setImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    //    }
    if (!_isReadABAdressBook) {
        [self configData];
    }
    // [_navigationBar reloadPeopleIcon];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    if (!self.title) {
        self.title = @"通讯录";
    }
    _alertView = nil;
    [self configData];
    [self configView];
}

- (void)configView {
    //    if ([[AppCacheManager sharedManager].loginUser.icon hasPrefix:@"http"]) {
    //        [self.peopleIconBtn sd_setImageWithURL:[NSURL URLWithString:[AppCacheManager sharedManager].loginUser.icon] forState:UIControlStateNormal];
    //    } else {
    //        [self.peopleIconBtn setImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    //    }
    //    self.peopleIconBtn.layer.cornerRadius = self.peopleIconBtn.frame.size.width / 2;
    //    self.peopleIconBtn.clipsToBounds = YES;

    if (_isMutableTouch) {
        _addressBookTableViewController = [[AdressBookTableViewController alloc] initWithNibName:@"AdressBookTableViewController" bundle:nil];
        _addressBookTableViewController.view.frame = self.backGroundView.bounds;
        _addressBookTableViewController.tableViewCanMultipeTouch = YES;
        [self addChildViewController:_addressBookTableViewController];
        [self.backGroundView addSubview:_addressBookTableViewController.view];
    } else {
        _globalScrollContainer.topView.fixedButtonCount = 2;
        _globalScrollContainer.topView.nameArray = @[ @"人脉", @"手机联系人" ];

        _globalScrollContainer.rootView.viewNameArray = @[ @"人脉", @"手机联系人" ];

        _globalScrollContainer.rootView.viewNameArray = _globalScrollContainer.topView.nameArray;

        _globalScrollContainer.topView.titleFontBlurColor = @"FB4F48";
        _globalScrollContainer.topView.titleFontFocusColor = @"313131";

        [_globalScrollContainer.topView initWithNameButtons];
        [_globalScrollContainer.rootView initWithViews];
        ;

//            [_globalScrollContainer.topView setBackgroundColor:[UIColor colorWithHexString:@"F6F6F6"]];
//            _globalScrollContainer.rootView.positionDelegate = self;

        _seaFriendTableViewController = [[SeaFriendTableViewController alloc] initWithNibName:@"SeaFriendTableViewController" bundle:nil];
        _seaFriendTableViewController.view.frame = self.backGroundView.bounds;
        //        _seaFriendTableViewController.viewHeader = self.searchView;
        //        _seaFriendTableViewController.viewHeaderHeight = self.searchView.height;
        [_globalScrollContainer addChildViewController:_seaFriendTableViewController];

        _addressBookTableViewController2 = [[AdressBookTableViewController alloc] initWithNibName:@"AdressBookTableViewController" bundle:nil];
        _addressBookTableViewController.view.frame = self.backGroundView.bounds;
        [_globalScrollContainer addChildViewController:_addressBookTableViewController2];

        _globalScrollContainer.rootContentSize = CGSizeMake(_globalScrollContainer.rootView.contentSize.width, 0);
    }

    //    [self.backGroundView addSubview:_addressBookTableViewController.view];

    [self updateAddressBook];
}

- (void)updateAddressBook {
    _addressBookTableViewController.addressBookInfoArray = _friendArry;
    [AppCacheManager sharedManager].friendAddressBookArray = _friendArry;
    _addressBookTableViewController2.addressBookInfoArray = _addressBookArry;
    [AppCacheManager sharedManager].addressBookArray = _addressBookArry;
}

- (void)configData {
    // local address book
    RHAddressBook *ab = [[RHAddressBook alloc] init];
    //    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(addressBookChanged:) name:RHAddressBookExternalChangeNotification object:nil];
    WEAKSELF
    [ab requestAuthorizationWithCompletion:^(bool granted, NSError *error) {
        
        weakSelf.isReadABAdressBook = YES;
        _addressBookArry = [NSMutableArray array];
        ABAddressBookRef addressBook;
        NSInteger peopleLong = [ab people].count;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSMutableArray *tempArry = [NSMutableArray array];
            for (int i = 0; i < peopleLong; i++) {
                RHPerson *person = [[ab people] objectAtIndex:i];
                AddressBookInfo *addressBookInfo = [[AddressBookInfo alloc] init];
                addressBookInfo.name = person.name;
                addressBookInfo.mobile = [[person phoneNumbers] valueAtIndex:0];
                
                if ([person.name isBlank]) {
                    continue;
                }
                
                [tempArry addObject:addressBookInfo];
                
                BOOL needRefresh = NO;
                if (i % 1000 == 0) {
                    needRefresh = YES;
                }
                else if (i % 800 == 0) {
                    needRefresh = YES;
                }
                else if (i % 300 == 0) {
                    needRefresh = YES;
                }
                else if (i % 150 == 0) {
                    needRefresh = YES;
                }
                else if (i % 50 == 0) {
                    needRefresh = YES;
                }
                
                if (needRefresh) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _addressBookArry = [tempArry copy];
                        [self updateAddressBook];
                    });
                }
            }
            _addressBookArry = [tempArry copy];
            [self updateAddressBook];
        });
        
        // network
        GetFriendRequest *getFriendRequest = [[GetFriendRequest alloc] init];
        getFriendRequest.uId = [AppCacheManager sharedManager].loginUserId;
        
        _emeGetFriendListHttpRequest = [[EMEHttpRequest alloc] initWithRequest:getFriendRequest];
        
        _friendArry = [NSMutableArray array];
        
        [_emeGetFriendListHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
            if (status == EMEHttpRequestStatusSuccess) {
                NSArray *friendList = ((MyFriend*)response).friendLst;
                for (Friend *friend in friendList){
                    AddressBookInfo *addressBookInfo = [[AddressBookInfo alloc]init];
                    addressBookInfo.id = friend.friend.id;
                    addressBookInfo.name = friend.friend.name;
                    addressBookInfo.mobile = friend.friend.mobile;
                    addressBookInfo.icon = friend.friend.icon;
                    [weakSelf.friendArry addObject:addressBookInfo];
                }
                
                [weakSelf updateAddressBook];
            }
            else {
            }
        }];
        
        [_emeGetFriendListHttpRequest sendRequest:MyFriend.class loadingTip:NO errorTip:YES];
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([RHAddressBook authorizationStatus] == RHAuthorizationStatusDenied){
            if (!_isReadABAdressBook && _alertView == nil) {
                _alertView = [[UIAlertView alloc] initWithTitle:@"读取通讯录权限关闭" message:@"请在ios系统 设置->隐私->通讯录 中打开商海通权限开关" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [_alertView show];
            }
        }
    });
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    alertView = nil;
    _alertView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)needShowBackView {
    return _isHideBack;
}

- (IBAction)searchClick:(id)sender {
    SearchViewController *searchViewController = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    searchViewController.dict = _dict;
    [self.navigationController pushViewController:searchViewController animated:YES];
}

- (IBAction)addContact:(id)sender {
}

- (IBAction)peopleIconClick:(UIButton *)sender {
//    ModifyUserInfoViewController *modifyUserInfoViewController = [[ModifyUserInfoViewController alloc] initWithNibName:@"ModifyUserInfoViewController" bundle:nil];
//    modifyUserInfoViewController.isUpdate = YES;
//    [self presentViewController:modifyUserInfoViewController animated:YES completion:nil];
}

@end
