//
//  WebViewController.m
//  EMESHT
//
//  Created by apple on 15/5/7.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "WebViewController.h"
#import "MBProgressHUD.h"

@interface WebViewController ()

@property (strong, nonatomic) MBProgressHUD *hud;
@end

@implementation WebViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.removeFromSuperViewOnHide = YES;
    [self.view addSubview:_hud];

    if (_htmlContent) {
        [_webView loadHTMLString:_htmlContent baseURL:nil];
    } else if (_url) {
        [_hud show:YES];
        _webView.delegate = self;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    }
}

- (void)setHtmlContent:(NSString *)htmlContent {
    _htmlContent = htmlContent;
    _webView.delegate = self;
    [_webView loadHTMLString:_htmlContent baseURL:nil];
}

- (void)setUrl:(NSString *)url {
    _url = url;
    [_hud show:YES];
    _webView.delegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_navbarHide) {
        _navbar.hidden = YES;
        _webView.frame = self.view.bounds;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_webView stopLoading];
}

- (void)dealloc {
    [_webView stopLoading];
}

#pragma mark -  UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_hud hide:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_hud hide:YES];
}

@end
