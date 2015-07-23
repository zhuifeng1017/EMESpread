//
//  WebViewController.h
//  EMESHT
//
//  Created by apple on 15/5/7.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMENavigationBar.h"

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (assign, nonatomic) BOOL navbarHide;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *htmlContent;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet EMENavigationBar *navbar;

@end
