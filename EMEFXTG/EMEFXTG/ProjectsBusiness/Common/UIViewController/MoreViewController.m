//
//  MoreViewController.m
//  EMEHS
//
//  Created by xuanhr on 14-8-14.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "MoreViewController.h"
#import "ChangeSkinViewController.h"
#import "EMEThemeLabel.h"
#import "AppCacheManager.h"
#import "EMEAppInfoEntity.h"
#import "EMEConstants.h"
#import "EMEPopViewController.h"
#import "Harpy.h"
#import "Version.h"
#import "EMEConfigManager.h"
#import "UpdateVersionViewController.h"

//#import "StoreCategoryListViewController.h"

@interface MoreViewController ()
@property (nonatomic, strong) EMEHttpRequest *emeVersionHttpRequest;
@property (nonatomic, strong) Version *version;
@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    _myArry = @[ @"新版本检查", @"退出登录" ];
    UITapGestureRecognizer *tapTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelf)];
    tapTouch.delegate = self;
    [self.view addGestureRecognizer:tapTouch];

    // add animation
    [self animationFromBottom:self.tableView];

    // add shadow
    self.backgroundView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.backgroundView.layer.shadowOffset = CGSizeMake(-1, 1);
    self.backgroundView.layer.shadowOpacity = 0.8;
    self.backgroundView.alpha = 1;
}

- (void)animationFromBottom:(UIView *)annimationView {
    annimationView.clipsToBounds = YES;
    const CGRect toFrame = annimationView.frame;
    self.view.alpha = 0;
    CGRect fromFrame = toFrame;
    fromFrame.size.height = 0;
    annimationView.frame = fromFrame;

    [UIView animateWithDuration:0.3f
        animations:^(void) {
                         self.view.alpha = 1.0f;
                         annimationView.frame = toFrame;
        }
        completion:^(BOOL completed) {}];
}

- (void)animationToBottom:(UIView *)annimationView {
    const CGRect fromFrame = annimationView.frame;
    CGRect toFrame = fromFrame;
    toFrame.size.height = 0;

    [UIView animateWithDuration:0.3f
        animations:^(void) {
                         
                         annimationView.alpha = 0.0f;
                         annimationView.frame = toFrame;
        }
        completion:^(BOOL completed) {
                         annimationView.frame = fromFrame;
                         [self.view removeFromSuperview];
                         [self removeFromParentViewController];
        }];
}

#pragma mark------UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    _tableView.height = [_myArry count] * 44;
    _backgroundView.height = _tableView.height;
    return [_myArry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];

    int labelTag = 1001;
    int backgroundTag = 29001;

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        EMEThemeLabel *label = [[EMEThemeLabel alloc] initWithFrame:cell.bounds];
        label.textAlignment = NSTextAlignmentLeft;
        if (_labelTextColor.length > 0) {
            label.textColor = [UIColor colorWithHexString:_labelTextColor];

        } else {
            label.textColorKey = @"backgroundColor";
        }
        label.font = [UIFont fontWithName:@"Arial" size:14];
        label.left = 8;
        label.tag = labelTag;
        [cell addSubview:label];

        if (cell.selectedBackgroundView.tag != backgroundTag) {
            UIView *backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
            backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.07f];
            backgroundView.tag = backgroundTag;
            cell.selectedBackgroundView = backgroundView;
        }
    }
    NSInteger row = [indexPath row];

    ((EMEThemeLabel *)[cell viewWithTag:labelTag]).text = [_myArry objectAtIndex:row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    _ChangeSkinVC = [[ChangeSkinViewController alloc] init];

    switch (row) {
    case 0: {
        [self queryVersion:YES];

        //            [[Harpy sharedInstance] checkVersion];
        //            [[NSNotificationCenter defaultCenter] postNotificationName:EMECheckAppVersionNotification object:nil];
        //            [(EMEPopViewController *)self.parentViewController dismiss];
        [self removeSelf];
        break;
    }
    case 1: {
        UIWindow *window = [UIApplication sharedApplication].windows[0];
        [(UINavigationController *)window.rootViewController popToRootViewControllerAnimated:NO];

        [(UINavigationController *)window.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:^{
                [(UINavigationController *)window.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
        }];

        [AppCacheManager sharedManager].isLogin = NO;
        [AppCacheManager sharedManager].loginUser = nil;
        [AppCacheManager sharedManager].loginUserId = nil;

        [self removeSelf];
        break;
    }
    case 2: {
        [EMEAppInfoEntity putValue:nil forKey:@"password"];

        [self removeSelf];
        //            [[NSNotificationCenter defaultCenter] postNotificationName:EME_NOTIFICATION_BACK_TO_STORECATEGORYLIST object:nil];
        break;
    }
    default:
        break;
    }
}

- (void)queryVersion:(BOOL)needAlreadyUpdatedVersionTip {
    CheckVersionRequest *request = [[CheckVersionRequest alloc] init];
    request.os = @"iOS";
    request.appCode = [[EMEConfigManager shareConfigManager] getAppCode];
    request.appVerNum = [[EMEConfigManager shareConfigManager] getAppVersionNumber];

    int clientAppVersionNumber = [request.appVerNum intValue];

    _emeVersionHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    //    __weak AppDelegate *weakSelf = self;
    WEAKSELF

    [_emeVersionHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            weakSelf.version = response;
            
            if ([weakSelf.version.appVerNum intValue] > clientAppVersionNumber) {
                
                if (needAlreadyUpdatedVersionTip) {
                    [weakSelf alertAlreadyUpdatedVersion];
                }
            }
            else if (needAlreadyUpdatedVersionTip) {
                //            [weakSelf alertAlreadyUpdatedVersion];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"已经是最新版本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }
        else {
        } 
    }];

    [_emeVersionHttpRequest sendRequest:Version.class loadingTip:NO errorTip:NO];
}

- (void)alertAlreadyUpdatedVersion {
    //    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请更新最新版本" delegate:nil cancelButtonTitle:@"去更新" otherButtonTitles:nil, nil];
    //    alertView.delegate = self;
    //    [alertView show];
    UpdateVersionViewController *updateVersionViewController = [[UpdateVersionViewController alloc] initWithNibName:@"UpdateVersionViewController" bundle:nil];
    updateVersionViewController.Version = _version;
    EMEPopViewController *popupViewController = [[EMEPopViewController alloc] initWithRootViewController:updateVersionViewController];
    [self.parentViewController pushViewController:popupViewController animated:YES popStyle:EMEPopStyleFromBottom];
}

- (void)removeSelf {

    [self animationToBottom:self.backgroundView];
}

- (void)addView {
    [self.parentViewController.view addSubview:self.view];
    //    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));

    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
