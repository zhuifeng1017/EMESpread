//
//  MaskingTipViewController.h
//  EMESHT
//
//  Created by appeme on 14-12-5.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MaskingTipViewTag 7000001

@interface MaskingTipView : UIView
@property (assign, nonatomic) CGRect maskingRect;
@end

@interface MaskingTipViewController : UIViewController
@property (assign, nonatomic) CGRect maskingRect;
@end

@interface MaskingTipManager : NSObject
@property (assign, nonatomic) BOOL tutorProcessing;
@property (copy, nonatomic) NSString *tutorType;

+ (instancetype)sharedManager;
- (BOOL)isTutorMode;
- (BOOL)hasShowTutor;
- (void)beginTutorProcessing;
- (void)endTutorProcessing;
- (void)showMaskingTipViewOnView:(UIView *)view;
- (void)hideMaskingTipViewOnView;
@end