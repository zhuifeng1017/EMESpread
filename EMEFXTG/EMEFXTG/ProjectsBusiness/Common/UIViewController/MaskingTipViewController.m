//
//  MaskingViewController.m
//  EMESHT
//
//  Created by appeme on 14-12-5.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "MaskingTipViewController.h"
#import "AppMessageManager.h"

@implementation MaskingTipViewController
-
    (void)viewDidLoad {
    [super viewDidLoad];

    self.view.tag = MaskingTipViewTag;
}

- (void)setMaskingRect:(CGRect)rect {
    _maskingRect = rect;
    ((MaskingTipView *)self.view).maskingRect = _maskingRect;
    self.view.tag = MaskingTipViewTag;
    [self.view setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

@implementation MaskingTipView
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"AA000000"].CGColor);
    CGContextFillRect(context, self.bounds);

    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"00000000"].CGColor);
    CGContextFillEllipseInRect(context, _maskingRect);

    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"FF33FF33"].CGColor);
    CGFloat dashArray[] = {6, 6, 6, 6};
    CGContextSetLineDash(context, 3, dashArray, 4); //跳过3个再画虚线，所以刚开始有6-（3-2）=5个虚点
    CGContextSetLineWidth(context, 2.0);
    CGContextAddEllipseInRect(context, _maskingRect);
    CGContextStrokePath(context);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return !CGRectContainsPoint(_maskingRect, point);
}

@end

@interface MaskingTipManager ()
@property (assign, nonatomic) BOOL hasShowTotor;
@property (weak, nonatomic) UIView *lastMaskParentView;
@end

@implementation MaskingTipManager

+ (instancetype)sharedManager {
    static MaskingTipManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MaskingTipManager alloc] init];
    });
    return sharedInstance;
}

- (BOOL)isTutorMode {
    return [[AppMessageManager sharedManager] getAppFakeTips].count > 0;
}

- (BOOL)hasShowTutor {
    return _hasShowTotor;
}

- (void)beginTutorProcessing {
    _tutorProcessing = YES;
}

- (void)endTutorProcessing {
    _tutorProcessing = NO;
}

- (void)showMaskingTipViewOnView:(UIView *)view {
    if (self.lastMaskParentView) {
        UIView *maskingView = [self.lastMaskParentView viewWithTag:MaskingTipViewTag];
        [maskingView removeFromSuperview];
    }

    UIView *maskParentView = [UIApplication sharedApplication].keyWindow;
    self.lastMaskParentView = maskParentView;

    [self hideMaskingTipViewOnView];

    MaskingTipViewController *maskingViewController = [[MaskingTipViewController alloc] initWithNibName:@"MaskingTipViewController" bundle:nil];
    [maskParentView addSubview:maskingViewController.view];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGRect maskRect = [view convertRect:view.bounds toView:maskParentView];
        maskingViewController.maskingRect = maskRect;
    });

    _hasShowTotor = YES;
}

- (void)hideMaskingTipViewOnView {
    UIView *maskParentView = [UIApplication sharedApplication].keyWindow;

    UIView *maskingView = [maskParentView viewWithTag:MaskingTipViewTag];

    [maskingView removeFromSuperview];

    _hasShowTotor = NO;
}

@end