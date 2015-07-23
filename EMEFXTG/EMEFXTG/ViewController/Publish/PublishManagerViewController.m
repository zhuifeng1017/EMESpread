//
//  PublishManagerViewController.m
//  EMEFXTG
//
//  Created by appeme on 15/7/23.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "PublishManagerViewController.h"
#import "ReleaseArtitleViewController.h"
#import "ReleaseGoodsViewController.h"
#import "PublishStep1ViewController.h"
#import "IStepViewControllerDatasource.h"
#import "AppUtils.h"
#import "PublishStep2ViewController.h"
#import "PublishStep3ViewController.h"
#import "PublishStep4ViewController.h"

@interface PublishManagerViewController () <SVPositionDelegate>
@property (assign, nonatomic) int lastStepIndex;
@end
@implementation
PublishManagerViewController
-
    (void)viewDidLoad {
    [super viewDidLoad];
    self.needKeyboardAssist = YES;

    [self configureData];
    [self configureView];
}

- (void)configureData {
}

- (void)configureView {
    if (_isNewPublish) {
        self.title = @"发布商品";
        _params = [NSMutableDictionary dictionary];
        _params[@"title"] = @"zhang3";
    } else {
        self.title = @"修改商品";
    }

    // init scroll pages
    _globalScrollContainer.rootView.viewNameArray = @[ @"view1", @"view2", @"view3", @"view4" ];

    PublishStep1ViewController *step1VC = [[PublishStep1ViewController alloc] init];
    step1VC.params = _params;
    [_globalScrollContainer addChildViewController:step1VC];

    [_globalScrollContainer.rootView initWithViews];
    _globalScrollContainer.rootView.positionDelegate = self;

    PublishStep2ViewController *step2VC = [[PublishStep2ViewController alloc] init];
    step2VC.params = _params;
    [_globalScrollContainer addChildViewController:step2VC];

    PublishStep3ViewController *step4ViewController = [[PublishStep3ViewController alloc] init];
    step4ViewController.params = _params;
    [_globalScrollContainer addChildViewController:step4ViewController];

    PublishStep4ViewController *step5ViewController = [[PublishStep4ViewController alloc] init];
    step5ViewController.params = _params;
    [_globalScrollContainer addChildViewController:step5ViewController];

    _globalScrollContainer.rootContentSize = CGSizeMake(_globalScrollContainer.rootView.contentSize.width, 0);
    // init page control
    _pageControl.numberOfPages = (int)_globalScrollContainer.rootView.viewNameArray.count;
    _pageControl.hasLine = YES;
    _pageControl.lineColor = [[EMEThemeManager sharedManager] colorForKey:EMEThemeBackgroundColor];
    _pageControl.thumbImage = [UIImage imageNamed:@"branch_dot02"];
    _pageControl.selectedThumbImage = [UIImage imageNamed:@"branch_dot01"];

    _pageControl.pageControlStyle = PageControlStyleThumb;

    // init supply info
}

- (void)positionChanged:(int)index {
    id<IStepViewControllerDatasource> stepDatasource = _globalScrollContainer.childrenViewController[_lastStepIndex];

    if (_lastStepIndex < index) {
        if (![stepDatasource fillData]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:[stepDatasource errorMessage] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];

            [_globalScrollContainer.rootView moveToIndex:_lastStepIndex];
            return;
        } else {
            _lastStepIndex = index;
        }
    } else {
        _lastStepIndex = index;
    }

    _pageControl.currentPage = _globalScrollContainer.rootView.currentPage;
    [self hideKeyboard];

    if (index == _globalScrollContainer.rootView.viewNameArray.count - 1) {
        [_saveButton setTitle:@"保 存" forState:UIControlStateNormal];
    } else {
        [_saveButton setTitle:@"下一步" forState:UIControlStateNormal];
    }
}

- (IBAction)nextClick:(id)sender {
    int index = _globalScrollContainer.rootView.currentPage;

    if (index == _globalScrollContainer.rootView.viewNameArray.count - 1) {
        BOOL fillDataSucc = YES;
        for (int i = 0; i < _globalScrollContainer.childrenViewController.count; i++) {
            id<IStepViewControllerDatasource> stepDatasource = _globalScrollContainer.childrenViewController[i];
            fillDataSucc &= [stepDatasource fillData];
        }

        if (fillDataSucc) {
            [self saveOrUpdatePublishRequest];
        } else {
            [AppUtils showAlertView:@"" message:@"图片上传中，稍后再试。"];
        }
    } else {
        id<IStepViewControllerDatasource> stepDatasource = _globalScrollContainer.childrenViewController[index];
        if (![stepDatasource fillData]) {
            [AppUtils showAlertView:@"" message:[stepDatasource errorMessage]];
            return;
        }

        [_globalScrollContainer.rootView moveToNext:YES];
    }
}

- (BOOL)popViewController {
    int index = _globalScrollContainer.rootView.currentPage;
    if (index >= 1) {
        [_globalScrollContainer.rootView moveToNext:NO];
        return YES;
    }

    return NO;
}

#pragma mark - Request
- (void)saveOrUpdatePublishRequest {
    [AppUtils showAlertView:@"" message:@"保存代码写了吗？"];
    if (_isNewPublish) {

    } else {
    }
}

@end
