//
//  AdressBookTableViewController.m
//  EMESHT
//
//  Created by xuanhr on 14-10-17.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "AdressBookTableViewController.h"
#import "AddressBookPopupViewController.h"
#import "EMEDatabaseManager.h"
#import "EMEConfigManager.h"
#import "UIImageView+WebCache.h"
#import <MessageUI/MessageUI.h>
#import "UIViewController+AnimationExtensions.h"
#import "AllUserEntity.h"
#import "RegExCategories.h"

@interface AdressBookTableViewController () <MFMessageComposeViewControllerDelegate>
@property (strong, nonatomic) NSMutableArray *selectIndexArry;
@property (strong, nonatomic) NSArray *keys;   //#,A,B
@property (strong, nonatomic) NSArray *values; //A=[AddressBookInfo[]]
@property (strong, nonatomic) NSArray *allNetworkUser;
@property (strong, nonatomic) NSArray *filterNetworkUser;

@end
static NSString *AddressBookListCellIdentifier = @"AddressBookListCellIdentifier";

@implementation AdressBookTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *condition = [NSString stringWithFormat:@"EnvironmentType='%@'", [[EMEConfigManager shareConfigManager] getEnvironmentType]];
    _allNetworkUser = [[[EMEDatabaseManager sharedInstance] allUserEntityDatabase] selectAll:condition];

    UINib *nib = [UINib nibWithNibName:@"AddressBookCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:AddressBookListCellIdentifier];

    _selectIndexArry = [NSMutableArray array];
}

- (void)processAddressBookSection {
    for (AddressBookInfo *addressBookInfo in self.addressBookInfoArray) {
        NSString *py = [ChineseToPinyin pinyinFromChiniseString:addressBookInfo.name];
        char ch = [ChineseToPinyin sortSectionTitle:py];

        addressBookInfo.pinyin = py;
        addressBookInfo.pinyinIndexChar = [NSString stringWithFormat:@"%c", ch];
    }

    NSArray *sortedArray = [self.addressBookInfoArray sortedArrayUsingComparator:^NSComparisonResult(AddressBookInfo *obj1, AddressBookInfo *obj2) {
        return [[obj1.pinyin lowercaseString] compare:[obj2.pinyin lowercaseString]];
    }];

    NSMutableArray *newKeys = [NSMutableArray array];
    NSMutableArray *newValues = [NSMutableArray array];

    int currentIndex = -1;
    for (AddressBookInfo *addressBookInfo in sortedArray) {
        if (![newKeys containsObject:addressBookInfo.pinyinIndexChar]) {
            
            if (!addressBookInfo.pinyinIndexChar) {
                continue;
            }
            
            [newKeys addObject:addressBookInfo.pinyinIndexChar];

            NSMutableArray *values = [NSMutableArray array];
            [newValues addObject:values];
            currentIndex++;
        }

        [newValues[currentIndex] addObject:addressBookInfo];
    }

    _keys = newKeys;
    _values = newValues;
}

- (void)setAddressBookInfoArray:(NSArray *)array {
    _addressBookInfoArray = array;

    [self processAddressBookSection];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_values[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];

    AddressBookCell *cell = (AddressBookCell *)[tableView dequeueReusableCellWithIdentifier:AddressBookListCellIdentifier];

    if (_tableViewCanMultipeTouch) {
        cell.iconImage.left = cell.selectButton.left + cell.selectButton.width + 12;
        cell.nameLabel.left = cell.iconImage.left + cell.iconImage.width + 8;
        cell.phoneLabel.left = cell.iconImage.left + cell.iconImage.width + 8;
        if ([_selectIndexArry containsObject:indexPath]) {
            [cell.selectButton setImage:[UIImage imageNamed:@"common_checkbox_selected"] forState:UIControlStateNormal];
        } else {
            [cell.selectButton setImage:[UIImage imageNamed:@"common_checkbox_noselected"] forState:UIControlStateNormal];
        }
    } else {
        cell.selectButton.hidden = YES;
    }
    AddressBookInfo *addressBookInfo = [_values[indexPath.section] objectAtIndex:row];

    cell.nameLabel.text = addressBookInfo.name;
    //    cell.iconImage.image = [UIImage imageNamed:staticArray[rand()%staticArray.count]];
    //    NSLog_d(@"cell contentView%@",NSStringFromCGRect(cell.contentView.frame));
    if ([addressBookInfo.icon hasPrefix:@"http"]) {
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:addressBookInfo.icon]];
    } else {
        [cell.iconImage setImage:[UIImage imageNamed:@"avatar"]];
    }
    if (addressBookInfo.id == nil) {
        cell.isFriendImage.hidden = YES;
    } else {
        cell.isFriendImage.hidden = NO;
    }
    [cell.nameLabel sizeToFit];
    cell.isFriendImage.left = cell.nameLabel.right + 8;

    cell.phoneLabel.text = addressBookInfo.mobile;

    cell.button1.hidden = YES;
    cell.button2.hidden = NO;
    [cell.button1 setImage:[UIImage imageNamed:@"icon_sht"] forState:UIControlStateNormal];

    NSString *contactMobile = @"";
    if (addressBookInfo.mobile) {
        contactMobile = [RX(@"[()\\-\\s+]") replace:addressBookInfo.mobile with:@""];
    }

    BOOL isSea = NO;
    for (AllUserEntity *tempFriend in _allNetworkUser) {

        if ([tempFriend.user.mobile isEqualToString:contactMobile]) {
            isSea = YES;
            break;
        }
    }
    if (isSea) {
        [cell.button2 setImage:[UIImage imageNamed:@"icon_sht"] forState:UIControlStateNormal];
        cell.button2.userInteractionEnabled = NO;

    } else {
        cell.button2.userInteractionEnabled = YES;
        [cell.button2 setImage:[UIImage imageNamed:@"btn_invite"] forState:UIControlStateNormal];
    }
    cell.button1.tag = indexPath.section * 10000 + indexPath.row;
    cell.button2.tag = indexPath.section * 10000 + indexPath.row;
    [cell.button1 addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button2 addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tableViewCanMultipeTouch) {
        if ([_selectIndexArry containsObject:indexPath]) {
            [_selectIndexArry removeObject:indexPath];
        } else {
            [_selectIndexArry addObject:indexPath];
        }
        [tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        AddressBookInfo *tempLogin = [_values[indexPath.section] objectAtIndex:indexPath.row];
        if (tempLogin.id == nil) {
            [self.view webCallPhone:tempLogin.mobile];
            return;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [_keys objectAtIndex:section];
    return key;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _keys;
}

- (NSArray *)getSelection {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _selectIndexArry.count; i++) {
        NSIndexPath *indexPath = _selectIndexArry[i];
        AddressBookInfo *info = _values[indexPath.section][indexPath.row];
        [array addObject:info];
    }

    return [array copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)button1Click:(UIButton *)sender {
    int senderId = sender.tag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:senderId % 10000 inSection:senderId / 10000];

    AddressBookInfo *info = _values[indexPath.section][indexPath.row];
    NSString *body = [NSString stringWithFormat:@"%@ 诚邀您加入中国高端众筹第一平台商海通，请点击下载地址下载: %@", [AppCacheManager sharedManager].loginUser.name, [AppCacheManager sharedManager].upgradeUrl];
    [self shareViaSms:body recipients:@[ info.mobile ]];
}

- (void)shareViaSms:(NSString *)body recipients:(NSArray *)recipients {
    if (![MFMessageComposeViewController canSendText]) {
        return;
    }

    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    controller.recipients = recipients;
    controller.body = body;
    controller.messageComposeDelegate = self;

    [self presentViewController:controller animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {

    switch (result) {
    case MessageComposeResultCancelled: {
        break;
    }
    case MessageComposeResultSent: {
        break;
    }
    case MessageComposeResultFailed: {
        break;
    }
    default: {
        break;
    }
    }

    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end

@implementation AddressBookCell

- (void)awakeFromNib {
    // Initialization code
    _isSelect = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
