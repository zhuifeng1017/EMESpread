//
//  AddressBookPopupViewController.h
//  EMESHT
//
//  Created by xuanhr on 14-10-31.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "EMEPopViewController.h"
#import "Friend.h"

@interface AddressBookPopupViewController : UIViewController
@property (strong, nonatomic) NSArray *dict;
- (IBAction)callPhoneClick:(id)sender;
- (IBAction)chatClick:(id)sender;
- (IBAction)jumpToPersonCenterClick:(id)sender;
- (IBAction)deleteClick:(id)sender;
- (IBAction)dismissClick:(id)sender;
@end
