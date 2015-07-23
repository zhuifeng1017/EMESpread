//
//  EMERecorderView.h
//  EMESHT
//
//  Created by Mac on 15-4-5.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHVoiceRecordHelper.h"

typedef void (^EMERecorderFinishBlock)(NSString *fileName);

@interface EMERecorderView : UIView
@property (strong, nonatomic) XHVoiceRecordHelper *voiceRecordHelper;
@property (copy, nonatomic) NSString *recorderDir;//default is %@/Documents/Audio/
@property (weak, nonatomic) IBOutlet UIButton *holdDownButton;
@property (weak, nonatomic) IBOutlet UIView *parentOfPopview;
- (void)setRecorderFinishBlock:(EMERecorderFinishBlock)block;
@end
