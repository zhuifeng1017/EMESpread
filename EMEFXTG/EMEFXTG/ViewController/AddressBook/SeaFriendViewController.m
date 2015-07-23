//
//  SeaFriendViewController.m
//  EMESHT
//
//  Created by appeme on 15/2/27.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "SeaFriendViewController.h"
#import "SeaFriendTableViewController.h"

@interface SeaFriendViewController ()
@property (strong, nonatomic) SeaFriendTableViewController *seaFriendTableViewController;
@end

@implementation SeaFriendViewController

- (void)viewDidLoad {
    self.needKeyboardAssist = YES;
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;

    _seaFriendTableViewController = [[SeaFriendTableViewController alloc] initWithNibName:@"SeaFriendTableViewController" bundle:nil];
    _seaFriendTableViewController.user = _user;
    [self addChildViewController:_seaFriendTableViewController];
    _seaFriendTableViewController.justShowFriend = YES;
    [_backView addSubview:self.seaFriendTableViewController.view];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _seaFriendTableViewController.view.frame = _backView.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)needShowBackView {
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
