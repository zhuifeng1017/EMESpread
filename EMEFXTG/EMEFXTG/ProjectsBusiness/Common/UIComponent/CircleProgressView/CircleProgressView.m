//
//  CircleProgressView.m
//  EMESHT
//
//  Created by appeme on 15/3/24.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "CircleProgressView.h"
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

#define DEGREES_TO_RADIANS(degrees) ((M_PI * degrees) / 180)

@implementation CircleProgressView

- (void)awakeFromNib {
    _lineWidth = 6;

    _label = [[NIAttributedLabel alloc] initWithFrame:CGRectMake(3, (self.height - 30) / 2 + 2, self.width, 30)];
    [self addSubview:_label];
}

- (void)displayLabel {
    _label.text = [NSString stringWithFormat:@"%d%%", _progress];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor redColor];

    int fromPosition = 1;
    if (_progress >= 100) {
        fromPosition = 3;
    } else if (_progress >= 10) {
        fromPosition = 2;
    }
    [_label setTextColor:[UIColor grayColor] range:NSMakeRange(fromPosition, 1)];
    [_label setFont:[UIFont systemFontOfSize:9] range:NSMakeRange(1, fromPosition)];
    [_label setFont:[UIFont systemFontOfSize:21] range:NSMakeRange(0, fromPosition)];

    [_label setVerticalTextAlignment:NIVerticalTextAlignmentTop];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    UIColor *color = [UIColor colorWithHexString:@"eeeeee"];
    [color set];

    UIBezierPath *path =
        [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2)
                                       radius:(self.width - _lineWidth) / 2 - 1
                                   startAngle:DEGREES_TO_RADIANS(0)
                                     endAngle:DEGREES_TO_RADIANS(360)
                                    clockwise:YES];
    path.lineWidth = _lineWidth;
    [path stroke];

    int startDegree = -90;
    int stopDegree = startDegree + (360 * _progress / 100);

    // two circle border
    color = [UIColor colorWithHexString:@"cccccc"];
    [color set];
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(1, 1, self.width - 2, self.width - 2)];
    [path stroke];

    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(1 + _lineWidth, 1 + _lineWidth, self.width - 2 * _lineWidth - 2, self.width - 2 * _lineWidth - 2)];
    [path stroke];

    // red
    color = [UIColor colorWithHexString:@"FF3333"];
    [color set];
    path =
        [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2)
                                       radius:(self.width - _lineWidth) / 2 - 1
                                   startAngle:DEGREES_TO_RADIANS(startDegree)
                                     endAngle:DEGREES_TO_RADIANS(stopDegree)
                                    clockwise:YES];
    path.lineWidth = _lineWidth;
    [path stroke];

    [self displayLabel];
}

- (void)refresh {
    [self setNeedsDisplay];
}
@end
