//
//  ImportContactViewController.m
//  EMESHT
//
//  Created by xuanhr on 14-10-20.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "ImportContactViewController.h"
#import "AddressBookViewController.h"

@interface ImportContactViewController ()

@end

@implementation ImportContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"添加亲友账号";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)jumpGo:(id)sender {
    AddressBookViewController *addressBookViewController = [[AddressBookViewController alloc] initWithNibName:@"AddressBookViewController" bundle:nil];
    [self.navigationController pushViewController:addressBookViewController animated:YES];
}

- (IBAction)addFriendClick:(id)sender {
}

@end
