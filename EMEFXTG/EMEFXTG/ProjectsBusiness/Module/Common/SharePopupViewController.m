//
//  SharePopupViewController.m
//  EMESHT
//
//  Created by appeme on 14-10-21.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "SharePopupViewController.h"
#import "EMEPopViewController.h"

@interface SharePopupViewController ()

@end

@implementation SharePopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _outerContainerView.backgroundColor = [UIColor colorWithHexString:@"33000000"];
    _outerContainerView.layer.cornerRadius = 10;
    _containerView.layer.cornerRadius = 8;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickShareButton:(UIButton *)sender {
    [(id)self.parentViewController dismiss];

    if (_shareDelegate) {
        [_shareDelegate clickShareType:sender.tag];
    }
}

+ (void)showSharePopOn:(UIViewController *)viewController withDelegate:(id<SharePopupDelegate>)delegate {
    SharePopupViewController *sharePopupViewController = [[SharePopupViewController alloc] init];
    EMEPopViewController *popupViewController = [[EMEPopViewController alloc] initWithRootViewController:sharePopupViewController];
    [viewController pushViewController:popupViewController animated:YES popStyle:EMEPopStyleFromBottom];
    popupViewController.view.backgroundColor = [UIColor clearColor];
    
    sharePopupViewController.shareDelegate = delegate;
}

+ (void)shareType:(ShareType)shareSDKtype contentIcon:(NSString *)contentIcon title:(NSString *)title description:(NSString *)description linkUrl:(NSString *)linkUrl {
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:contentIcon ofType:@"png"];
    NSString *jumpUrl = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:title defaultContent:@"分享" image:[ShareSDK imageWithPath:imagePath]
                title:title url:jumpUrl description:description mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK clientShareContent:publishContent type:shareSDKtype statusBarTips:YES result:
     ^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
         if (state == SSResponseStateSuccess) {
             NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
         } else if (state == SSResponseStateFail) {
             NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
         }
     }];
}

@end
