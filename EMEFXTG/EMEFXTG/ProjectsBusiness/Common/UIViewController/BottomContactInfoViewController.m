//
//  BottomContactInfoViewController.m
//  EMEHS-MGT
//
//  Created by appeme on 14-9-11.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "BottomContactInfoViewController.h"

@interface BottomContactInfoViewController ()

@end

@implementation BottomContactInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *contactInfoString = self.infoLabel.text;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:contactInfoString];
    [attrString addAttribute:NSFontAttributeName value:self.infoLabel.font range:NSMakeRange(0, contactInfoString.length)];
    [attrString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:[contactInfoString rangeOfString:@"查看帮助"]];
    [attrString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:[contactInfoString rangeOfString:@"021-32556857"]];

    self.infoLabel.attributedText = attrString;
    [self.infoLabel setTextColor:[UIColor darkGrayColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)helpClick:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"帮助" message:@"请联系伊墨科技" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)phoneClick:(id)sender {
    [self.view webCallPhone:@"400-920-8989"];
}

- (void)dealloc {
}
@end
