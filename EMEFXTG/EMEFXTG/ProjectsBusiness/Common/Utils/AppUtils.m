//
//  AppUtils.m
//  EMESHT
//
//  Created by apple on 15/3/27.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "AppUtils.h"
#import "User.h"
#import "EMEImageButton.h"
#import "EMEPopViewController.h"
#import "UIImageView+WebCache.h"
#import "AllUserEntity.h"
#import "EMEDatabaseManager.h"
#import "MBProgressHUD.h"

@implementation AppUtils

+ (BOOL)isAppStore {
    NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
    BOOL appStore = [[identifier lowercaseString] containsString:@"appstore"];
    return appStore;
}

+ (void)gotoPersonalCenter:(User *)user viewController:(UIViewController *)viewController {
//    MineViewController *vc = [[MineViewController alloc] initWithNibName:@"MineViewController" bundle:nil];
//    vc.user = user;
//
//    if ([viewController isKindOfClass:[UINavigationController class]]) {
//        [(UINavigationController *)viewController pushViewController:vc animated:YES];
//    } else {
//        [viewController.navigationController pushViewController:vc animated:YES];
//    }
}

+ (void)showPersonalPopMenu:(User *)user viewController:(UIViewController *)viewController {
//    PersonCenterViewController *vc = [[PersonCenterViewController alloc] init];
//    vc.user = user;
//    EMEPopViewController *popupViewController = [[EMEPopViewController alloc] initWithRootViewController:vc];
//    [viewController pushViewController:popupViewController animated:YES popStyle:EMEPopStyleFromBottom];
}

+ (UIImageView *)messageVoiceAnimationImageViewWithBubbleMessageType:(NSInteger)type {
//    UIImageView *messageVoiceAniamtionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    NSString *imageSepatorName;
//    switch (type) {
//    case XHBubbleMessageTypeSending:
//        imageSepatorName = @"Sender";
//        break;
//    case XHBubbleMessageTypeReceiving:
//        imageSepatorName = @"Receiver";
//        break;
//    default:
//        break;
//    }
//    NSMutableArray *images = [NSMutableArray arrayWithCapacity:4];
//    for (NSInteger i = 0; i < 4; i++) {
//        UIImage *image = [UIImage imageNamed:[imageSepatorName stringByAppendingFormat:@"VoiceNodePlaying00%d", i]];
//        if (image)
//            [images addObject:image];
//    }
//
//    messageVoiceAniamtionImageView.image = images.lastObject;
//    messageVoiceAniamtionImageView.animationImages = images;
//    messageVoiceAniamtionImageView.animationDuration = 1.0;
//    [messageVoiceAniamtionImageView stopAnimating];
//
//    return messageVoiceAniamtionImageView;
    return nil;
}

+ (NSString *)audioCacheDir {
    NSString *cacheDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Audio"];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NSFileManager defaultManager] createDirectoryAtPath:cacheDir withIntermediateDirectories:YES attributes:nil error:nil];
    });
    return cacheDir;
}

+ (void)showAlertView:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil];
    [alertView show];
}

+ (void)showGlobalHUD:(NSString *)text {
    [AppUtils showGlobalHUD:text detailsText:nil duration:1.2];
}

+ (void)showGlobalHUD:(NSString *)text duration:(NSTimeInterval)duration {
    [AppUtils showGlobalHUD:text detailsText:nil duration:duration];
}

+ (void)showGlobalHUD:(NSString *)text detailsText:(NSString *)detailsText duration:(NSTimeInterval)duration {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:window];
    [window addSubview:hud];
    hud.labelText = text;
    hud.detailsLabelText = detailsText;
    hud.mode = MBProgressHUDModeText;
    [hud show:YES];
    [hud hide:YES afterDelay:duration];
}

+ (void)sd_setWebImage:(UIImageView *)imageView withUrl:(NSString *)url {
    if ([url hasPrefix:@"http"]) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
    }
    else {
        imageView.image = [UIImage imageNamed:url];
    }
}

+ (User *)getUserById:(NSString *)userId {
    AllUserEntity *userEntity = nil;
    NSArray *users = [[EMEDatabaseManager sharedInstance].allUserEntityDatabase selectAll:[NSString stringWithFormat:@"uid = '%@'", userId]];
    if (users.count > 0) {
        userEntity = users[0];
    }
    return userEntity.user;
}

+ (NSString *)moneyFormateString:(unsigned int)money {
    NSMutableString *mstring = [[NSMutableString alloc] initWithString:[@(money) stringValue]];
    int startPos = (int)mstring.length - 3;
    int i = startPos;
    for (; i > 0; i -= 3) {
        [mstring insertString:@"," atIndex:i];
    }
    return mstring;
}

+ (NSString *)getAppName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

+ (NSString *)getAppDisplayName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)getAppBundleId {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

+ (void)setLeftTextMargin:(UITextField *)textField withLeftMargin:(int)left {
    UIView *emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, left, 1)];
    textField.leftView = emptyView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

@end
