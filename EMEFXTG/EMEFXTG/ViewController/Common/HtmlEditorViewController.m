//
//  HtmlEditorViewController.m
//
//  Created by Appeme on 15-6-23.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "HtmlEditorViewController.h"
#import <objc/runtime.h>
#import "EMEPopViewController.h"
#import "UIView+EMEFW.h"
#import "ImagePickAndUploader.h"
#import "MicroGoodsInputAlertViewController.h"

@interface HtmlEditorViewController () <UIActionSheetDelegate, ImageUploaderDelegate>
@property (nonatomic, strong) UIView *toolbarHolder;
@property (nonatomic, strong) NSString *htmlString;
@property (nonatomic) CGRect webviewFrame;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) ImagePickAndUploader *imagePickAndUploader;
@end

@implementation HtmlEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"良品介绍";

    NSURL *url = [[NSBundle mainBundle] URLForResource:@"HtmlEditor" withExtension:@"html"];
    [_webview loadRequest:[NSURLRequest requestWithURL:url]];
    _webview.hidesInputAccessoryView = YES;
    _webview.keyboardDisplayRequiresUserAction = NO;
    _webview.dataDetectorTypes = UIDataDetectorTypeNone;
    _webview.scrollView.bounces = NO;
    _webview.backgroundColor = [UIColor whiteColor];

    self.toolbarHolder = [[NSBundle mainBundle] loadNibNamed:@"HtmlEditorToolbar" owner:self options:nil][0];
    self.toolbarHolder.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;

    [self configureData];
    [self configureToolbar];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.toolbarHolder.top = self.webview.bottom;
        [self.view addSubview:self.toolbarHolder];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [_timer invalidate]; // Stop it while we work
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(checkSelection:) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_timer invalidate];
}

- (void)configureData {
    _imagePickAndUploader = [[ImagePickAndUploader alloc] init];
}

- (void)configureToolbar {
    for (int i=1; i<=7; i++) {
        UIButton *button = (UIButton *)[self.toolbarHolder viewWithTag:i];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)clickButton:(UIButton *)sender {
    if (sender.tag == 1) {
        [_webview stringByEvaluatingJavaScriptFromString:@"saveSelection()"];
        
        _imagePickAndUploader.delegate2 = self;
        _imagePickAndUploader.needCompress = YES;
        [_imagePickAndUploader showPickDialog:self imageView:nil];
    } else if (sender.tag == 2) {
        [_webview stringByEvaluatingJavaScriptFromString:@"saveSelection()"];
        [self.view endEditing:YES];
        
        MicroGoodsInputAlertViewController *innerViewController = [[MicroGoodsInputAlertViewController alloc] init];
        EMEPopViewController *popupViewController = [[EMEPopViewController alloc] initWithRootViewController:innerViewController];
        [self pushViewController:popupViewController animated:YES popStyle:EMEPopStyleFromBottom];
        __weak EMEPopViewController *weakPopupViewController = popupViewController;
        
        WEAKSELF;
        [innerViewController setActionBlock:^(NSString *action, id from, id object) {
            [weakSelf.webview stringByEvaluatingJavaScriptFromString:@"restoreSelection()"];

            if ([action isEqualToString:@"insert"]) {
                NSString *trigger = [NSString stringWithFormat:@"document.execCommand('InsertHtml',false,'<video src=\"%@\" width=\"320\" height=\"200\" controls autoplay></video>')", object];
                [weakSelf.webview stringByEvaluatingJavaScriptFromString:trigger];
            }
            
            [weakPopupViewController dismiss];
        }];
        
    } else if (sender.tag == 3) {
        [_webview stringByEvaluatingJavaScriptFromString:@"document.execCommand('Bold')"];
    } else if (sender.tag == 4) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择文字颜色" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"蓝色", @"黄色", @"绿色", @"红色", @"橙色", nil];
        [actionSheet showInView:self.view];
    } else if (sender.tag == 5) {
        int size = [[_webview stringByEvaluatingJavaScriptFromString:@"document.queryCommandValue('fontSize')"] intValue];
        size = (size == 3) ? 4 : 3;
        [_webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('fontSize', false, '%i')", size]];
    } else if (sender.tag == 6) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"HtmlEditor" withExtension:@"html"];
        [_webview loadRequest:[NSURLRequest requestWithURL:url]];
    } else if (sender.tag == 7) {
        [self.view endEditing:YES];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *selectedButtonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    selectedButtonTitle = [selectedButtonTitle lowercaseString];
    
    if ([actionSheet.title isEqualToString:@"Select a font"]) {
        [_webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('fontName', false, '%@')", selectedButtonTitle]];
    } else {
        NSDictionary *colorDict = @{@"蓝色":@"blue", @"黄色":@"yellow", @"绿色":@"green", @"红色":@"red", @"橙色":@"orange"};
        [_webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('foreColor', false, '%@')", colorDict[selectedButtonTitle]]];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            UITextField *imageURL = [alertView textFieldAtIndex:0];
            UITextField *alt = [alertView textFieldAtIndex:1];
            [self insertImage:imageURL.text alt:alt.text];
        }
    } else if (alertView.tag == 2) {
        if (buttonIndex == 1) {
            UITextField *linkURL = [alertView textFieldAtIndex:0];
            UITextField *title = [alertView textFieldAtIndex:1];

            [self insertLink:linkURL.text title:title.text];
        }
    }
    
}

- (void)checkSelection:(id)sender {
    //image, video, bold, color, size, delete, hide
    UIButton *button = nil;
    
    // bold
    BOOL boldEnabled = [[_webview stringByEvaluatingJavaScriptFromString:@"document.queryCommandState('Bold')"] boolValue];
    button = (UIButton *)[self.toolbarHolder viewWithTag:3];
    [button setTitleColor:(boldEnabled ? [UIColor darkGrayColor] : [UIColor lightGrayColor]) forState:UIControlStateNormal];
    UIFont *buttonFont = boldEnabled ? [UIFont boldSystemFontOfSize:15] : [UIFont systemFontOfSize:15];
    button.titleLabel.font = buttonFont;
    
    // color
    NSString *foreColorString = [_webview stringByEvaluatingJavaScriptFromString:@"document.queryCommandValue('foreColor')"];
    UIColor *fontColor = [self colorFromRGBValue:foreColorString];
    button = (UIButton *)[self.toolbarHolder viewWithTag:4];

    UIView *line = [self.toolbarHolder viewWithTag:10];
    if (foreColorString && !fontColor) {
        NSDictionary *colorDict = @{@"blue":[UIColor blueColor], @"yellow":[UIColor yellowColor], @"green":[UIColor greenColor], @"red":[UIColor redColor], @"orange":[UIColor orangeColor]};
        fontColor = colorDict[foreColorString];
    }
    
    line.backgroundColor = fontColor;
    
    //size
    int size = [[_webview stringByEvaluatingJavaScriptFromString:@"document.queryCommandValue('fontSize')"] intValue];
    button = (UIButton *)[self.toolbarHolder viewWithTag:5];
    [button setTitle:(size == 3 ? @"A-" : @"A+") forState:UIControlStateNormal];
}

- (void)keyboardWillShowOrHide:(NSNotification *)notification {
    // Orientation
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    // User Info
    NSDictionary *info = notification.userInfo;
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    int curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    CGRect keyboardEnd = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // Toolbar Sizes
    CGFloat sizeOfToolbar = self.toolbarHolder.frame.size.height;
    
    // Keyboard Size
    //Checks if IOS8, gets correct keyboard height
    CGFloat keyboardHeight = UIInterfaceOrientationIsLandscape(orientation) ? ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.000000) ? keyboardEnd.size.height : keyboardEnd.size.width : keyboardEnd.size.height;
    
    // Correct Curve
    UIViewAnimationOptions animationOptions = curve << 16;
    
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
        
        [UIView animateWithDuration:duration delay:0 options:animationOptions animations:^{
//            self.webview.scrollView.contentInset = UIEdgeInsetsZero;
//            self.webview.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
            
            self.webview.height = self.view.frame.size.height - keyboardHeight - sizeOfToolbar - 64;
            self.toolbarHolder.top = self.webview.bottom;
        } completion:nil];
    } else {
        [UIView animateWithDuration:duration delay:0 options:animationOptions animations:^{
            self.webview.height = self.view.frame.size.height - sizeOfToolbar - 64;
            self.toolbarHolder.top = self.webview.bottom;
        } completion:nil];
    }
}

#pragma mark - Utils
- (void)insertImage:(NSString *)url alt:(NSString *)alt {
    NSString *trigger = [NSString stringWithFormat:@"document.execCommand('InsertImage',false,'%@');", url];
    [self.webview stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)insertLink:(NSString *)url title:(NSString *)title {
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.insertLink(\"%@\", \"%@\");", url, title];
    [self.webview stringByEvaluatingJavaScriptFromString:trigger];
}

- (UIColor *)colorFromRGBValue:(NSString *)rgb { // General format is 'rgb(red, green, blue)'
    if ([rgb rangeOfString:@"rgb"].location == NSNotFound)
    return nil;
    
    NSMutableString *mutableCopy = [rgb mutableCopy];
    [mutableCopy replaceCharactersInRange:NSMakeRange(0, 4) withString:@""];
    [mutableCopy replaceCharactersInRange:NSMakeRange(mutableCopy.length-1, 1) withString:@""];
    
    NSArray *components = [mutableCopy componentsSeparatedByString:@","];
    int red = [[components objectAtIndex:0] intValue];
    int green = [[components objectAtIndex:1] intValue];
    int blue = [[components objectAtIndex:2] intValue];
    
    UIColor *retVal = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    return retVal;
}

#pragma mark - ImageUploaderDelegate
- (void)onImageUploadCompletion:(ImageUploader *)imageUploader success:(BOOL)success message:(NSString *)message {
    if (success) {
        int imageWidth = 320;
        if (imageUploader.image.size.width > 0) {
            imageWidth = imageUploader.image.size.width * 200 / imageUploader.image.size.height;
        }
        [_webview stringByEvaluatingJavaScriptFromString:@"restoreSelection()"];
        NSString *trigger = [NSString stringWithFormat:@"document.execCommand('InsertHtml',false,'<img width=%d height=200 src=\"%@\"/>')", imageWidth, message];
        [self.webview stringByEvaluatingJavaScriptFromString:trigger];
    }
}

- (IBAction)saveClick:(id)sender {
    NSString *exportHtml = [_webview stringByEvaluatingJavaScriptFromString:@"document.getElementById('content').innerHTML"];

}
@end

#pragma mark - UIViewView
@implementation UIWebView (HackishAccessoryHiding)

static const char * const hackishFixClassName = "UIWebBrowserViewMinusAccessoryView";
static Class hackishFixClass = Nil;

- (UIView *)hackishlyFoundBrowserView {
    UIScrollView *scrollView = self.scrollView;
    
    UIView *browserView = nil;
    for (UIView *subview in scrollView.subviews) {
        if ([NSStringFromClass([subview class]) hasPrefix:@"UIWebBrowserView"]) {
            browserView = subview;
            break;
        }
    }
    return browserView;
}

- (id)methodReturningNil {
    return nil;
}

- (void)ensureHackishSubclassExistsOfBrowserViewClass:(Class)browserViewClass {
    if (!hackishFixClass) {
        Class newClass = objc_allocateClassPair(browserViewClass, hackishFixClassName, 0);
        newClass = objc_allocateClassPair(browserViewClass, hackishFixClassName, 0);
        IMP nilImp = [self methodForSelector:@selector(methodReturningNil)];
        class_addMethod(newClass, @selector(inputAccessoryView), nilImp, "@@:");
        objc_registerClassPair(newClass);
        
        hackishFixClass = newClass;
    }
}

- (BOOL) hidesInputAccessoryView {
    UIView *browserView = [self hackishlyFoundBrowserView];
    return [browserView class] == hackishFixClass;
}

- (void) setHidesInputAccessoryView:(BOOL)value {
    UIView *browserView = [self hackishlyFoundBrowserView];
    if (browserView == nil) {
        return;
    }
    [self ensureHackishSubclassExistsOfBrowserViewClass:[browserView class]];
    
    if (value) {
        object_setClass(browserView, hackishFixClass);
    }
    else {
        Class normalClass = objc_getClass("UIWebBrowserView");
        object_setClass(browserView, normalClass);
    }
    [browserView reloadInputViews];
}

@end
