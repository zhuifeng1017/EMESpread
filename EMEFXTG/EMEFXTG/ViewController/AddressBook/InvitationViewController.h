//
//  InvitationViewController.h
//  EMESHT
//
//  Created by xuanhr on 14-11-12.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"
#import "AddressBookViewController.h"

@interface InvitationViewController : AddressBookViewController
//@property (strong, nonatomic) NSArray *dict;
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
- (IBAction)skipClick:(id)sender;
- (IBAction)finishClick:(id)sender;

@end
