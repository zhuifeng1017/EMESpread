//
//  SearchViewController.m
//  EMESHT
//
//  Created by xuanhr on 14-10-23.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "SearchViewController.h"
#import "ContactPeople.h"
#import "AdressBookTableViewController.h"
#import "EMEPopViewController.h"
#import "UIImageView+WebCache.h"
#import "AppCacheManager.h"
#import "MaskingTipViewController.h"

@interface SearchViewController ()
@property (strong, nonatomic) NSString *searchString;
@property EMEHttpRequest *emeAllUserQueryHttpRequest;
@property (assign, nonatomic) BOOL needShowTutor;
@end

@implementation SearchViewController
static NSString *AddressBookListCellIdentifier = @"AddressBookListCellIdentifier";

- (void)viewDidLoad {
    self.needKeyboardAssist = YES;
    [super viewDidLoad];

    UINib *nib = [UINib nibWithNibName:@"AddressBookCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:AddressBookListCellIdentifier];

    if ([_textField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor colorWithWhite:1 alpha:.7];
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_textField.placeholder attributes:@{NSForegroundColorAttributeName : color}];

    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
    }

    _searchString = [NSString stringWithFormat:@""];
    [self textLengthChange:self.textField];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self tryToMaskCustomerService];
}

- (void)tryToMaskCustomerService {
    if ([MaskingTipManager sharedManager].tutorProcessing) {
        _searchString = @"1";
        _needShowTutor = YES;
        [self configData];
    }
}

- (void)configData {

    QueryUserRequest *queryUserRequest = [[QueryUserRequest alloc] init];
    queryUserRequest.param = _searchString;
    queryUserRequest.service = @(_needShowTutor);
    queryUserRequest.pageSize = @50;
    _emeAllUserQueryHttpRequest = [[EMEHttpRequest alloc] initWithRequest:queryUserRequest];

    WEAKSELF

    [_emeAllUserQueryHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            weakSelf.dataArry = (NSArray*)response;
            [weakSelf.tableView reloadData];
        }
        else {
        }
    }];

    [_emeAllUserQueryHttpRequest sendRequest:User.class loadingTip:YES errorTip:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    if ([self.textField.text length] <= 0) {
    //        return [self.contactDic count];
    //    } else {
    //        return [self.searchByName count] + [self.searchByPhone count];
    //    }
    return [_dataArry count];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressBookCell *cell = (AddressBookCell *)[tableView dequeueReusableCellWithIdentifier:AddressBookListCellIdentifier];

    if (_needShowTutor) {
        if (![[MaskingTipManager sharedManager].tutorType hasPrefix:@"system-fake-tip1"]) {
            [[MaskingTipManager sharedManager] showMaskingTipViewOnView:cell];
            _needShowTutor = NO;
        } else if ([[MaskingTipManager sharedManager].tutorType isEqual:@"system-fake-tip1"] && indexPath.row == 0) {
            [[MaskingTipManager sharedManager] showMaskingTipViewOnView:cell];
            _needShowTutor = NO;
        } else if ([[MaskingTipManager sharedManager].tutorType isEqual:@"system-fake-tip1a"] && indexPath.row == 1) {
            [[MaskingTipManager sharedManager] showMaskingTipViewOnView:cell];
            _needShowTutor = NO;
        }
    }

    User *user = [_dataArry objectAtIndex:indexPath.row];
    cell.selectButton.hidden = YES;
    cell.nameLabel.text = user.name;
    cell.phoneLabel.text = user.mobile;
    if (user.icon.length == 0) {
        [cell.iconImage setImage:[UIImage imageNamed:@"avatar"]];
    } else {
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:user.icon]];
    }
    [cell.nameLabel sizeToFit];
    cell.isFriendImage.left = cell.nameLabel.right + 8;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideKeyboard];

    User *user = [_dataArry objectAtIndex:indexPath.row];
    if ([[AppCacheManager sharedManager].loginUser.id isEqualToString:user.id]) {
        return;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [_textField addTarget:self action:@selector(textLengthChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textLengthChange:(UITextField *)textfield {
    //    [[SearchCoreManager share] Search:textfield.text searchArray:nil nameMatch:_searchByName phoneMatch:self.searchByPhone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseClick:(id)sender {
}

- (IBAction)searchClick:(id)sender {
    _searchString = _textField.text;
    _dataArry = [[NSArray alloc] init];
    [self configData];
}
@end
