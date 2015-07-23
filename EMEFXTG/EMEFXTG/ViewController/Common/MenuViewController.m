//
//  MenuViewController.m
//  EMESHT
//
//  Created by appeme on 15/2/28.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "MenuViewController.h"
#import "EMEPopViewController.h"
#import "MALTabBarViewController.h"
#import "NSObject+ExtraObject.h"

@interface MenuViewController ()
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _backColorView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    _buttonContainer.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//- (void)jumpToPublish:(BOOL)isNeed {
////    PublishNeedAndSupplyViewController *publishNeedAndSupplyViewController = [[PublishNeedAndSupplyViewController alloc] initWithNibName:@"PublishNeedAndSupplyViewController" bundle:nil];
////    publishNeedAndSupplyViewController.isNeed = isNeed;
////    [[MALTabBarViewController getTabBar:self] presentViewController:publishNeedAndSupplyViewController animated:YES completion:nil];
////
////    EMEPopViewController *popViewController = (EMEPopViewController *)self.parentViewController;
////    popViewController.animated = NO;
////    [popViewController dismiss];
//}

- (IBAction)chatClick:(id)sender {
//    DemoChatListViewController *demoChatListViewController = [[DemoChatListViewController alloc] init];
//    demoChatListViewController.otherNavigationController = self.navigationController;
//    [demoChatListViewController rightBarButtonItemPressed:nil];

    //    ChatListViewController *chatListViewController = [[ChatListViewController alloc] initWithNibName:@"ChatListViewController" bundle:nil];
    //    chatListViewController.needShowAddChatGroup = YES;
    //    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:chatListViewController];
    //    [self.parentViewController presentViewController:navController animated:YES completion:nil];

    EMEPopViewController *popViewController = (EMEPopViewController *)self.parentViewController;
    popViewController.animated = NO;
    [popViewController dismiss];
}

- (IBAction)publishGnosisClick:(id)sender {

}

- (IBAction)publishActivityClick:(id)sender {

}

- (IBAction)invitationClick:(id)sender {

}

- (IBAction)scheduleClick:(id)sender {

}

@end
