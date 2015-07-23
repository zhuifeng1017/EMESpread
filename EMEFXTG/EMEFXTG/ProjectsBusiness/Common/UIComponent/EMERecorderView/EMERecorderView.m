//
//  EMERecorderView.m
//  EMESHT
//
//  Created by Mac on 15-4-5.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "EMERecorderView.h"
#import "XHVoiceRecordHUD.h"
#import "XHMacro.h"
#import "XHMessageInputView.h"
#import "XHFoundationMacro.h"
#import "XHMessageBubbleFactory.h"
#import "XHVoiceCommonHelper.h"
#import "Mp3Convertor.h"

@interface EMERecorderView ()
@property (nonatomic, strong) XHVoiceRecordHUD *voiceRecordHUD;
@property (copy, nonatomic) EMERecorderFinishBlock finishBlock;
@property (copy, nonatomic) NSString *recorderFilePath;
@property (strong, nonatomic) Mp3Convertor *convertor;
@end

@implementation EMERecorderView

- (void)awakeFromNib {
    [self configureHoldButton];
}

- (void)configureHoldButton {
    [_holdDownButton setTitle:@"按住 说话" forState:UIControlStateNormal];
    [_holdDownButton setTitle:@"松开 结束" forState:UIControlStateHighlighted];
    [_holdDownButton addTarget:self action:@selector(startRecord) forControlEvents:UIControlEventTouchDown];
    [_holdDownButton addTarget:self action:@selector(cancelRecord) forControlEvents:UIControlEventTouchUpOutside];
    [_holdDownButton addTarget:self action:@selector(finishRecorded) forControlEvents:UIControlEventTouchUpInside];
    [_holdDownButton addTarget:self action:@selector(resumeRecord) forControlEvents:UIControlEventTouchDragExit];
    [_holdDownButton addTarget:self action:@selector(pauseRecord) forControlEvents:UIControlEventTouchDragEnter];

#if DEBUG
//   [self performSelector:@selector(startRecord) withObject:nil afterDelay:1.5];
//NSString *filePath = [NSTemporaryDirectory() stringByAppendingString:@"/2015-04-13-02-52-25-MySound.caf"];
//[self convertToMp3:filePath];
#endif
}

#pragma mark - voice event
- (void)startRecord {
    NSAssert(_parentOfPopview, @"must set parentOfPopview!");

    self.recorderFilePath = [self getRecorderPath];

    [self.voiceRecordHUD startRecordingHUDAtView:self.parentOfPopview];
    [self.voiceRecordHelper startRecordingWithPath:self.recorderFilePath StartRecorderCompletion:^{}];

    DLog(@"startRecord");
}

- (void)finishRecorded {
    WEAKSELF
    [self.voiceRecordHUD stopRecordCompled:^(BOOL fnished) {
        weakSelf.voiceRecordHUD = nil;
    }];
    [self.voiceRecordHelper stopRecordingWithStopRecorderCompletion:^{
        //        [weakSelf didSendMessageWithVoice:weakSelf.voiceRecordHelper.recordPath voiceDuration:weakSelf.voiceRecordHelper.recordDuration];
        //[weakSelf convertToMp3:weakSelf.recorderFilePath];
        if (weakSelf.finishBlock) {
            weakSelf.finishBlock(weakSelf.recorderFilePath);
        }
    }];

    DLog(@"finishRecorded");
}

- (void)pauseRecord {
    [self.voiceRecordHUD pauseRecord];

    DLog(@"pauseRecord");
}

- (void)resumeRecord {
    [self.voiceRecordHUD resaueRecord];

    DLog(@"resumeRecord");
}

- (void)cancelRecord {
    WEAKSELF
    [self.voiceRecordHUD cancelRecordCompled:^(BOOL fnished) {
        weakSelf.voiceRecordHUD = nil;
    }];
    [self.voiceRecordHelper cancelledDeleteWithCompletion:^{}];
}

- (void)didStartRecordingVoiceAction {
    DLog(@"didStartRecordingVoice");
    [self startRecord];
}

- (void)didCancelRecordingVoiceAction {
    DLog(@"didCancelRecordingVoice");
    [self cancelRecord];
}

- (void)didFinishRecoingVoiceAction {
    DLog(@"didFinishRecoingVoice");
    [self finishRecorded];
}

- (void)didDragOutsideAction {
    DLog(@"didDragOutsideAction");
    [self resumeRecord];
}

- (void)didDragInsideAction {
    DLog(@"didDragInsideAction");
    [self pauseRecord];
}

#pragma mark - helper
- (XHVoiceRecordHUD *)voiceRecordHUD {
    if (!_voiceRecordHUD) {
        _voiceRecordHUD = [[XHVoiceRecordHUD alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
    }
    return _voiceRecordHUD;
}

- (XHVoiceRecordHelper *)voiceRecordHelper {
    if (!_voiceRecordHelper) {
        WEAKSELF
        _voiceRecordHelper = [[XHVoiceRecordHelper alloc] init];
        _voiceRecordHelper.maxTimeStopRecorderCompletion = ^{
            DLog(@"已经达到最大限制时间了，进入下一步的提示");
            [weakSelf finishRecorded];
        };
        _voiceRecordHelper.peakPowerForChannel = ^(float peakPowerForChannel) {
            weakSelf.voiceRecordHUD.peakPower = peakPowerForChannel;
        };
        _voiceRecordHelper.maxRecordTime = kVoiceRecorderTotalTime;
    }
    return _voiceRecordHelper;
}

#pragma mark - recorder path
- (NSString *)getRecorderPath {
    NSString *recorderPath = nil;
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    if (!_recorderDir) {
        _recorderDir = @"%@/tmp/";
    }

    recorderPath = [[NSString alloc] initWithFormat:_recorderDir, NSHomeDirectory()];
    dateFormatter.dateFormat = @"yyyy-MM-dd-hh-mm-ss";
    recorderPath = [recorderPath stringByAppendingFormat:@"%@-MySound.%@", [dateFormatter stringFromDate:now], kVoiceRecorderFileType];
    return recorderPath;
}

- (void)setRecorderFinishBlock:(EMERecorderFinishBlock)block {
    _finishBlock = [block copy];
}

#pragma mark-- convert caf to mp3
- (void)convertToMp3:(NSString *)cafFile {
    if (_convertor == nil) {
        _convertor = [[Mp3Convertor alloc] init];
    }

    NSLog(@"start convert mp3");
    WEAKSELF;
    NSString *mp3FilePath = [cafFile stringByAppendingString:@".mp3"];
    [_convertor toMp3:cafFile mp3OutFilePath:mp3FilePath finishBlock:^(BOOL ret) {
        NSLog(ret?@"转码成功":@"转码失败");
        NSLog(@"end convert mp3");
        if (weakSelf.finishBlock) {
            weakSelf.finishBlock(mp3FilePath);
        }
    } progressBlock:^(int progress) {}];
}
@end
