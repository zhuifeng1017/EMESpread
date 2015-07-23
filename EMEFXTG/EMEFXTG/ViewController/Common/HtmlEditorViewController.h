//
//  HtmlEditorViewController.h
//
//  Created by Appeme on 15-6-23.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HtmlEditorViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)saveClick:(id)sender;
@end


@interface UIWebView (HackishAccessoryHiding)
@property (nonatomic, assign) BOOL hidesInputAccessoryView;
@end
