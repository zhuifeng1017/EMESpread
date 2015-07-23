//
//  IIIFlowCell.h
//  IIIThumbFlow
//
//  Created by sehone on 12/21/12.
//  Copyright (c) 2012 sehone <sehone@gmail.com>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIIBaseData.h"
// Padding width for thumbs
#define iii_const_common_cell_padding 3.0f
#define iii_const_common_bg_color [UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1.0]

@interface IIIFlowCell : UIView
@property BOOL isDownloading;
@property (strong, nonatomic) NSString *reuseId;
@property (strong, nonatomic) UIImageView *image;

- (id)initWithReuseId:(NSString *)idStr;
- (void)loadWithImage:(UIImage *)image cellWidth:(CGFloat)width;
- (void)unload;

@end
