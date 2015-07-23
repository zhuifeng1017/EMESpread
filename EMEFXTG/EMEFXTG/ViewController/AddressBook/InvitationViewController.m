//
//  InvitationViewController.m
//  EMESHT
//
//  Created by xuanhr on 14-11-12.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "InvitationViewController.h"
#import "AdressBookTableViewController.h"
#import "UITableView+EMEUI.h"

@interface InvitationViewController ()
@end

@implementation InvitationViewController

- (void)viewDidLoad {
    self.isMutableTouch = YES;
    [super viewDidLoad];

    self.title = self.title ?: @"发起聊天";
    self.addressBookTableViewController.tableViewCanMultipeTouch = YES;
    
    [self.addressBookTableViewController.tableView enableEmptyView:YES tipText:@"暂无好友"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)skipClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)needShowBackView {
    return YES;
}

- (IBAction)finishClick:(id)sender {
    WEAKSELF
    [self.navigationController popViewControllerAnimated:YES];
    
    NSArray *array = [self.addressBookTableViewController getSelection];
    if (weakSelf.selectionDelegate) {
        [weakSelf.selectionDelegate completeSelection:array];
    }

}

@end
