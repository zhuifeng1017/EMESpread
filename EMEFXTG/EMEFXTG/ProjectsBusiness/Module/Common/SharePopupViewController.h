//
//  SharePopupViewController.h
//  EMESHT
//
//  Created by appeme on 14-10-21.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>

@protocol SharePopupDelegate <NSObject>
@optional
- (void)clickShareType:(int)type;
@end

@interface SharePopupViewController : UIViewController
@property (weak, nonatomic) id<SharePopupDelegate> shareDelegate;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *outerContainerView;

+ (void)showSharePopOn:(UIViewController *)viewController withDelegate:(id<SharePopupDelegate>)delegate;
+ (void)shareType:(ShareType)shareSDKtype contentIcon:(NSString *)carrierIcon title:(NSString *)title description:(NSString *)description linkUrl:(NSString *)linkUrl;

- (IBAction)clickShareButton:(UIButton *)sender;
@end
