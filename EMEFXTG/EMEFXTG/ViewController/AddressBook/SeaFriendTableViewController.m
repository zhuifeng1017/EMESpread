//
//  SeaFriendTableViewController.m
//  EMESHT
//
//  Created by xuanhr on 15/2/11.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "SeaFriendTableViewController.h"
#import "EMEDatabaseManager.h"
#import "EMEConfigManager.h"
#import "UIImageView+WebCache.h"
#import <MessageUI/MessageUI.h>
#import "UIViewController+AnimationExtensions.h"
#import "NetApiFriendHelper.h"
#import "AllUserEntity.h"
#import "NetApiChatGroupHelper.h"
#import "UIAlertViewO.h"
#import "UITableView+EMEUI.h"
#import "NetApiHelper.h"

@interface SeaFriendTableViewController ()
@property (strong, nonatomic) NSArray *friendArray;
@property (strong, nonatomic) NSArray *allNetworkUser;
@property (strong, nonatomic) NSArray *filterNetworkUser;
@property (strong, nonatomic) NSMutableArray *tempAddedFriendArray;
@end

static NSString *SeaFriendCellIdentifier = @"SeaFriendCellIdentifier";

@implementation SeaFriendTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    _tempAddedFriendArray = [NSMutableArray array];
    [self getFriendRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    UINib *nib = [UINib nibWithNibName:@"SeaFriendCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:SeaFriendCellIdentifier];

    _tableView.delegate = self;
    _tableView.dataSource = self;

    _searchBGView.layer.borderColor = [UIColor colorWithHexString:@"DFDFDF"].CGColor;
    _searchBGView.layer.borderWidth = 1;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:nil];

    if (!_justShowFriend) {
        [self initFilter];
    }
}

- (void)initFilter {
    NSString *condition = [NSString stringWithFormat:@"EnvironmentType='%@'", [[EMEConfigManager shareConfigManager] getEnvironmentType]];
    _allNetworkUser = [[[EMEDatabaseManager sharedInstance] allUserEntityDatabase] selectAll:condition];

    if (_justShowFriend) {
        NSMutableArray *justFriendArray = [NSMutableArray array];
        for (int i = 0; i < _allNetworkUser.count; i++) {
            AllUserEntity *entity = _allNetworkUser[i];
            if ([self isFriend:entity.uId]) {
                [justFriendArray addObject:entity];
            }
        }
        _allNetworkUser = justFriendArray;
    }

    _filterNetworkUser = [NSMutableArray arrayWithArray:_allNetworkUser];
}

#pragma mark - net request
- (void)getFriendRequest {
    NSString *userId = (_user != nil) ? _user.id : [AppCacheManager sharedManager].loginUserId;
    WEAKSELF
    [NetApiFriendHelper getFriendWithUId:userId withBlock:^(NSString *message, NSArray *friendLst) {
        if ([message isEqualToString:@"success"]) {
            _friendArray = [friendLst copy];
            
            if (_justShowFriend) {
                [weakSelf initFilter];
            }
            [weakSelf.tableView reloadData];
        }
        
        [weakSelf.tableView enableEmptyView:YES tipText:@"暂无数据"];
    }];
}

- (BOOL)isFriend:(NSString *)otherUserId {
    BOOL isFriend = NO;
    if ([_tempAddedFriendArray containsObject:otherUserId]) {
        isFriend = YES;
    } else {
        for (Friend *tempFriend in _friendArray) {
            if ([tempFriend.friend.id isEqualToString:otherUserId]) {
                isFriend = YES;
                break;
            }
        }
    }
    return isFriend;
}

#pragma mark - textFiledEditChanged
- (void)textFiledEditChanged:(NSNotification *)notification {
    UITextField *textField = notification.object;

    if (textField == _searchTF) {
        if (textField.text.length == 0) {
            [self initFilter];
            [self.tableView reloadData];
        } else {
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(searchClick:) object:nil];
            [self performSelector:@selector(searchClick:) withObject:nil afterDelay:.7];
        }
    }
}

#pragma mark - tableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_filterNetworkUser count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SeaFriendCell *cell = (SeaFriendCell *)[tableView dequeueReusableCellWithIdentifier:SeaFriendCellIdentifier];
    Login *user = ((AllUserEntity *)_filterNetworkUser[indexPath.row]).user;
    BOOL isFriend = [self isFriend:user.id];

    cell.addFriendBtn.tag = indexPath.row;
    [cell.addFriendBtn removeTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.addFriendBtn removeTarget:self action:@selector(sendMessageClick:) forControlEvents:UIControlEventTouchUpInside];

    if (_justShowFriend) {
        cell.friendLabel.hidden = YES;
        cell.addFriendBtn.hidden = YES;
    } else {
        if (isFriend) {
            cell.friendLabel.hidden = NO;
            cell.addFriendBtn.hidden = YES;
        } else {
            cell.friendLabel.hidden = YES;
            cell.addFriendBtn.hidden = NO;
            [cell.addFriendBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }

    cell.nameLabel.text = user.name;
    [cell.nameLabel sizeToFit];

    cell.companyName.text = user.company.name;
    NSMutableString *tempPostionString = [[NSMutableString alloc] initWithCapacity:20];
    for (int i = 0; i < [user.job.position count]; i++) {
        NSString *tempString = user.job.position[i];
        if ((i + 1) == [user.job.position count]) {
            [tempPostionString appendString:tempString];
        } else {
            [tempPostionString appendString:[NSString stringWithFormat:@"%@,", tempString]];
        }
    }

    if ([user.icon hasPrefix:@"http://"]) {
        [cell.peopleIcon sd_setImageWithURL:[NSURL URLWithString:user.icon]];
    } else {
        [cell.peopleIcon setImage:[UIImage imageNamed:@"avatar"]];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    Login *user = ((AllUserEntity *)_filterNetworkUser[indexPath.row]).user;
//    MineViewController *vc = [[MineViewController alloc] init];
//    vc.user = user;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return _viewHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return _viewHeader;
}

#pragma mark - click event
- (void)addClick:(UIButton *)sender {
    Login *user = ((AllUserEntity *)_filterNetworkUser[sender.tag]).user;

    WEAKSELF
    RIButtonItem *cancelItem = [RIButtonItem itemWithLabel:@"取消" action:nil];
    RIButtonItem *deleteItem = [RIButtonItem itemWithLabel:@"确定" action:^{
        SaveFriendRequest *saveFriendRequest = [[SaveFriendRequest alloc] init];
        saveFriendRequest.uId = [AppCacheManager sharedManager].loginUserId;
        saveFriendRequest.fId = user.id;
        
        [NetApiHelper sendRequest:saveFriendRequest forResponse:[MyFriend class] loadingTip:YES errorTip:YES successTip:nil withBlock:^(NSString *message, id responses) {
            if ([message isEqual:@"success"]) {
                NSArray *friendLst = ((MyFriend*)responses).friendLst;
                
//                [[RongChatAgent sharedInstance] setAppFriends:friendLst];
                
                [weakSelf.tempAddedFriendArray addObject:user.id];
                [weakSelf.tableView reloadData];
            }
        }];
    }];

    NSString *alertString = [NSString stringWithFormat:@"确定要关注'%@'吗？", user.name];

    UIAlertView *alertView = [[UIAlertViewO alloc] initWithTitle:@""
                                                         message:alertString
                                                cancelButtonItem:cancelItem
                                                otherButtonItems:deleteItem, nil];
    [alertView show];
}

- (void)sendMessageClick:(UIButton *)sender {
    Login *user = ((AllUserEntity *)_filterNetworkUser[sender.tag]).user;

    WEAKSELF
    [NetApiChatGroupHelper createNewChatGroup:@[ user.id ] withBlock:^(NSString *message, UserGroup *userGroup) {
        
        if ([message isEqualToString:@"success"]) {
//            XHWeChatMessageTableViewController *chatDialogViewController = [[XHWeChatMessageTableViewController alloc] init];
//            chatDialogViewController.paramUserGroup = userGroup;
//            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:chatDialogViewController];
//            navController.navigationBarHidden = YES;
//            [weakSelf.parentViewController presentViewController:navController animated:YES completion:nil];
        }
        else {
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchClick:(UIButton *)sender {
    if ([_searchTF.text isEqualToString:@""]) {
        return;
    }

    NSString *lowerText = [_searchTF.text lowercaseString];

    NSMutableArray *tempArray = [NSMutableArray array];
    for (AllUserEntity *user in _allNetworkUser) {
        if ([user.pinyin containsString:lowerText]) {
            [tempArray addObject:user];
        } else if ([user.pinyinAbbr containsString:lowerText]) {
            [tempArray addObject:user];
        } else if ([[user.user.name lowercaseString] containsString:lowerText]) {
            [tempArray addObject:user];
        } else if ([[user.user.company.name lowercaseString] containsString:lowerText]) {
            [tempArray addObject:user];
        } else if (user.user.job.position.count > 0) {
            for (int i = 0; i < user.user.job.position.count; i++) {
                if ([[user.user.job.position[i] lowercaseString] containsString:lowerText]) {
                    [tempArray addObject:user];
                    break;
                }
            }
        }
    }
    _filterNetworkUser = [tempArray copy];
    [self.tableView reloadData];
}
@end

#pragma mark - SeaFriendCell
@implementation SeaFriendCell

- (void)awakeFromNib {
    // Initialization code
    self.peopleIcon.layer.cornerRadius = self.peopleIcon.frame.size.width / 2;
    self.peopleIcon.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end