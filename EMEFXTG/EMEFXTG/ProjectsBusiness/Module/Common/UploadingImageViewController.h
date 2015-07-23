//
//  UploadingImageViewController.h
//  EMESHT
//
//  Created by xuanhr on 15/3/2.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberButton.h"

typedef void (^ImageUploadCompleteBlock)(NSArray* imageArrary);

@interface UploadingImageViewController : UIViewController
@property (assign, nonatomic) double aspectRatio;
@property (weak, nonatomic) IBOutlet UIScrollView* scroll;
@property (weak, nonatomic) IBOutlet UIButton* addMemberButton;
@property (strong, nonatomic) NSMutableArray* checkButtonNumberArray;

@property (strong, nonatomic) NSMutableArray* imageInfoArry;
@property (strong, nonatomic) NSMutableArray *memberInfoArray;


@property (assign, nonatomic) NSInteger itemCountInLine;
@property (assign, nonatomic) MemberButtonType type;
- (void)uploadCompletionBlock:(ImageUploadCompleteBlock)block;
- (void)insertTopContainerBar;
- (void)addImage;

@end
