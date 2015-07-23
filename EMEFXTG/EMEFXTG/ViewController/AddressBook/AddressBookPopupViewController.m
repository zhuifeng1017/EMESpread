//
//  AddressBookPopupViewController.m
//  EMESHT
//
//  Created by xuanhr on 14-10-31.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "AddressBookPopupViewController.h"
#import "AdressBookTableViewController.h"
#import "InvitationViewController.h"

@interface AddressBookPopupViewController ()

@end

@implementation AddressBookPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callPhoneClick:(id)sender {
    [(EMEPopViewController *)self.parentViewController dismiss];
}

- (IBAction)chatClick:(id)sender {
    InvitationViewController *invitationViewController = [[InvitationViewController alloc] initWithNibName:@"InvitationViewController" bundle:nil];
    invitationViewController.dict = _dict;
    [self presentViewController:invitationViewController animated:YES completion:nil];
    [(EMEPopViewController *)self.parentViewController dismiss];
}

- (IBAction)jumpToPersonCenterClick:(id)sender {
    [(EMEPopViewController *)self.parentViewController dismiss];
}

- (IBAction)deleteClick:(id)sender {
    [(EMEPopViewController *)self.parentViewController dismiss];
}

- (IBAction)dismissClick:(id)sender {
    [(EMEPopViewController *)self.parentViewController dismiss];
}
@end
