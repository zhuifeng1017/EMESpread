//
//  SpreadViewController.m
//  class-timetable
//
//  Created by Mac on 15-7-17.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import "SpreadViewController.h"
#import "iCarousel.h"
#import "SpreadInfoView.h"
#import "AppDelegate.h"
#import "AppUtils.h"
#import "SharePopupViewController.h"
#import "User.h"
#import <ShareSDK/ShareSDK.h>
#import "NetApiHelper.h"
#import "Login.h"
#import "AppCacheManager.h"
#import "SMSAuthViewController.h"
#import "PasswordConfirmViewController.h"
#import "Content.h"
#import "SpreadDetailViewController.h"
#import "SpreadLoginViewController.h"
#import "Product.h"
#import "SpreadWelcomeViewController.h"
#import "DetailsViewController.h"
#import "BasePopViewController.h"

@interface SpreadViewController () <SharePopupDelegate, iCarouselDataSource, iCarouselDelegate>
@property (copy, nonatomic) NSString *currentContent;
@property (strong, nonatomic) NSMutableArray *cards;
@property (strong, nonatomic) BasePopViewController *popOpenModeViewController;
@end

@implementation SpreadViewController

- (void)viewDidLoad {
    [self showWelcome];
    self.navigationController.navigationBarHidden = YES;
    [super viewDidLoad];

    _cards = [@[ @1, @2, @3, @4, @5, @1, @2, @3, @4, @5, @1, @2, @3, @4, @5, @1, @2, @3, @4, @5 ] mutableCopy];

    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.type = iCarouselTypeRotary;
    _carousel.pagingEnabled = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewProduct:) name:@"viewProductNotification" object:nil];

    //    WEAKSELF;
    //    FindProductRequest *request = [[FindProductRequest alloc] init];
    //    [NetApiHelper sendRequest:request forResponse:[Product class] loadingTip:YES errorTip:YES successTip:nil withArrayBlock:^(NSString *message, NSArray *responses) {
    //        if ([message isEqual:@"success"]) {
    //            weakSelf.cards = [responses mutableCopy];
    //        }
    //    }];
}

- (void)showWelcome {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLaunch"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isFirstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        SpreadWelcomeViewController *welcomeVC = [[SpreadWelcomeViewController alloc] init];
        [self.navigationController presentViewController:welcomeVC animated:NO completion:NULL];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewProduct:(NSNotification *)nofi {
    NSDictionary *dict = [nofi userInfo];
    NSString *content_id = [dict objectForKey:@"content_id"];
    NSString *from_id = [dict objectForKey:@"from_id"];
    NSString *to_id = [dict objectForKey:@"to_id"];

    NSLog(@"NSNotification dict:  %@, %@, %@", content_id, from_id, to_id);
}

- (IBAction)loginCancelBtnClick:(UIButton *)sender {
    [ShareSDK cancelAuthWithType:ShareTypeWeixiSession];
}

- (IBAction)removeCardClick:(id)sender {
    if (_cards.count > 1) {
        [_cards removeObjectAtIndex:_carousel.currentItemIndex];
        [_carousel reloadData];
    } else {
        [AppUtils showAlertView:@"" message:@"这是最后一个商品了，不能删除。"];
    }
}

- (IBAction)loginBtnClick:(UIButton *)sender {
    [((AppDelegate *)[UIApplication sharedApplication].delegate)thirdPartyLoginInfo:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        if (!result) {
            [AppUtils showAlertView:@"" message:[error errorDescription]];
            return;
        }
        NSDictionary *dict = [userInfo sourceData];
        
        NSString *unionid = dict[@"unionid"];
        NSString *token = [[userInfo credential] token];
        NSString *openId = [[userInfo credential] uid];
        NSLog(@"openId: %@", openId);
        NSLog(@"unionid: %@", unionid);
        
        WXUser *user = [[WXUser alloc] init];
        user.openid = openId;
        user.nickname = dict[@"nickname"];
        user.headimgurl = dict[@"headimgurl"];
        user.sex = dict[@"sex"];
        user.province = dict[@"province"];
        user.city = dict[@"city"];
        
        WXLoginRequest *request = [[WXLoginRequest alloc] init];
        request.accessToken = token;
        request.unionId = unionid;
        request.openid = openId;
        request.uInfo = user;
        [NetApiHelper sendRequest:request forResponse:[WXLogin class] loadingTip:YES errorTip:YES successTip:nil withBlock:^(NSString *message, id response) {
            if ([message isEqualToString:@"success"]) { // 微信登陆成功
                WXLogin *login = (WXLogin*)response;
                [AppCacheManager sharedManager].isLogin = YES;
                [AppCacheManager sharedManager].loginUserId = login.id;
                [AppCacheManager sharedManager].wxloginUser = login;
                [AppCacheManager sharedManager].wxUnionId = unionid;
                NSLog(@"loginUserId : %@", login.id);
                
                if ([login.loginName isBlank]) {
                    SMSAuthViewController *vc = [[SMSAuthViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [AppUtils showGlobalHUD:@"登录成功"];
                }
            }
        }];
    }];
}

- (IBAction)shareClick:(id)sender {
    if (![AppCacheManager sharedManager].isLogin) {
        [AppUtils showAlertView:@"" message:@"请先登录"];
        return;
    }
    [SharePopupViewController showSharePopOn:self.parentViewController withDelegate:self];
}

//@"eme://spread/launch?content_id=xx&from_id=xx&to_id=xx
- (void)clickShareType:(int)type {
    SaveContentRequest *contentRequest = [[SaveContentRequest alloc] init];
    contentRequest.userId = [AppCacheManager sharedManager].loginUserId;
    contentRequest.title = [NSString stringWithFormat:@"Title %d", (int)self.carousel.currentItemIndex];

    [NetApiHelper sendRequest:contentRequest forResponse:[SaveContent class] loadingTip:YES errorTip:YES successTip:@"上传内容成功" withBlock:^(NSString *message, id response) {
        if ([message isEqualToString:@"success"]) {
            SaveContent *content = (SaveContent*)response;
            NSString *shareUrl = [NSString stringWithFormat:@"http://www.sht.appeme.com/spread/index.html?content_id=%@", content.id];
            [SharePopupViewController shareType:type contentIcon:@"launch120" title:contentRequest.title description:@"分享来自伊墨科技" linkUrl:shareUrl];
        }
    }];
}

#pragma mark - Carousel Delegate
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return _cards.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    Product *product = _cards[index];

    SpreadInfoView *infoView = [[NSBundle mainBundle] loadNibNamed:@"SpreadInfoView" owner:self options:nil][0];
    infoView.layer.masksToBounds = YES;
    infoView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    infoView.layer.borderWidth = 1;
    infoView.layer.cornerRadius = 4;

    //    infoView.tmpLabel.text = product.title;
    infoView.imageView.image = [UIImage imageNamed:(index % 2 ? @"preview1" : @"preview2")];
    infoView.shareNumLabel.text = [NSString stringWithFormat:@"剩余%d个", index];
    infoView.rewardLabel.text = [NSString stringWithFormat:@"￥%d", index * 10];
    infoView.payLabel.text = [NSString stringWithFormat:@"￥%d", index * 100];

    return infoView;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    if (option == iCarouselOptionRadius && carousel.numberOfItems < 2) {
        return 30;
    }
    return value;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform {

    if (carousel.currentItemIndex == offset) {
        return CATransform3DTranslate(transform, offset * 292, 0.0, offset * 20.0);
    } else {
        return CATransform3DTranslate(transform, offset * 292, 0.0, offset * 20.0);
    }
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    _popOpenModeViewController = [[BasePopViewController alloc] initWithCustomXib:@"SpreadOpenModePopView"];
    UIView *customView = [_popOpenModeViewController showPopOn:self withBackgroundColor:[UIColor colorWithHexString:@"33000000"]];
    UIButton *detailButton = (UIButton *)[customView viewWithTag:1];
    UIButton *spreadDetailButton = (UIButton *)[customView viewWithTag:2];

    [detailButton addTarget:self action:@selector(detailClick:) forControlEvents:UIControlEventTouchUpInside];
    [spreadDetailButton addTarget:self action:@selector(spreadDetailClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)detailClick:(id)sender {
    [_popOpenModeViewController dismiss:YES];

    Product *product = _cards[0];

    DetailsViewController *vc = [[DetailsViewController alloc] init];
    vc.paramProduct = product;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)spreadDetailClick:(id)sender {
    [_popOpenModeViewController dismiss:YES];

    Product *product = _cards[0];

    SpreadDetailViewController *vc = [[SpreadDetailViewController alloc] init];
    vc.paramProduct = product;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)personClick:(id)sender {
    SpreadLoginViewController *vc = [[SpreadLoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)menuClick:(id)sender {
    [[SlideNavigationController sharedInstance] toggleLeftMenu];
}

- (IBAction)rightMenuClick:(id)sender {
    [[SlideNavigationController sharedInstance] toggleRightMenu];
}

#pragma mark - SlideNavigationControllerDelegate
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu {
    return YES;
}

@end
