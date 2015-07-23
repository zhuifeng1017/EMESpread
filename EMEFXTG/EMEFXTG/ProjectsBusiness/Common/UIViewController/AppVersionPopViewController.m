//
//  AppVersionPopViewController.m
//  EMEHS-MGT
//
//  Created by appeme on 14-9-19.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "AppVersionPopViewController.h"
#import "EMEPopViewController.h"

@interface AppVersionPopViewController ()

@end

@implementation AppVersionPopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithHexString:@"CC000000"];
    self.descriptionLabel.text = _version.appDesc;
    [self.descriptionLabel sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateClick:(id)sender {
    NSString *iTunesString = [NSString stringWithFormat:@"http://%@", _version.appUrl];
    NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
    [[UIApplication sharedApplication] openURL:iTunesURL];

    //    [(EMEPopViewController *)self.parentViewController dismiss];
}
@end
