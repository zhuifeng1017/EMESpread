//
//  ChangeSkinViewController.h
//  EMEHS
//
//  Created by xuanhr on 14-8-14.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeSkinViewController : UIViewController <UIGestureRecognizerDelegate>
- (void)attachToWindow;
@property (weak, nonatomic) IBOutlet UIView *paletteView;
@end
