//
//  PopupMenuHelper.h
//  EMESHT
//
//  Created by appeme on 14-10-17.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHPopUpMenu.h"

@interface PopupMenuHelper : NSObject <CHPopUpMenuDelegate>
+ (PopupMenuHelper *)sharedInstance;
@property (nonatomic, strong) CHPopUpMenu *popupMenu;
- (void)attachToView:(UIView *)view onViewController:(UIViewController *)viewController top:(int)top;
@end
