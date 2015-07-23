//
//  MapSummaryViewController.m
//  EMEHS
//
//  Created by Mac on 14-8-19.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "MapSummaryViewController.h"
#import "UIColor+HexString.h"

@interface MapSummaryViewController ()

@end

@implementation MapSummaryViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self updateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateView {
    for (UIView *v in self.detailContainer.subviews) {
        [v removeFromSuperview];
    }

    int cellHight = 41;
    switch (self.searchType) {
    case AMapSearchType_NaviDrive: {
        self.detailContainer.height = self.path.steps.count * cellHight;
        for (int i = 0; i < self.path.steps.count; i++) {
            AMapStep *step = self.path.steps[i];
            UILabel *routeLabel = [self createUILabelWithContent:step.instruction Frame:CGRectMake(10, i * cellHight, 280, cellHight)];

            routeLabel.numberOfLines = 0;
            [self.detailContainer addSubview:routeLabel];

            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, i * cellHight, 320, 1)];
            lineView.backgroundColor = [UIColor colorWithHexString:@"#CCCCCC"];
            [self.detailContainer addSubview:lineView];

            if (i < self.path.steps.count - 1) {
                UIImageView *dotView = [self createUIImageViewWithImage:[UIImage imageNamed:@"g_line_x"] Frame:CGRectMake(0, (i + 1) * cellHight, 300, 1)];
                [self.detailContainer addSubview:dotView];
            }
        }
        break;
    }
    case AMapSearchType_NaviWalking: {
        self.detailContainer.frame = CGRectMake(10, 110, 300, self.path.steps.count * cellHight);
        for (int i = 0; i < self.path.steps.count; i++) {
            AMapStep *step = self.path.steps[i];
            UILabel *routeLabel = [self createUILabelWithContent:step.instruction Frame:CGRectMake(10, i * cellHight, 280, cellHight)];

            routeLabel.numberOfLines = 2;
            [self.detailContainer addSubview:routeLabel];

            if (i < self.path.steps.count - 1) {
                UIImageView *dotView = [self createUIImageViewWithImage:[UIImage imageNamed:@"g_line_x"] Frame:CGRectMake(0, (i + 1) * cellHight, 300, 1)];
                [self.detailContainer addSubview:dotView];
            }
        }
        break;
    }
    default:
    AMapSearchType_NaviBus : {
        int buscount = 0;
        for (int j = 0; j < self.transit.segments.count; j++) {
            AMapSegment *segment = self.transit.segments[j];
            AMapBusLine *busline = segment.busline;

            if (busline != nil) {
                buscount++;
                self.detailContainer.frame = CGRectMake(10, 110, 300, buscount * cellHight);

                UILabel *routeLabel = [self createUILabelWithContent:[NSString stringWithFormat:@"%@:%@-->%@", busline.name, busline.departureStop.name, busline.arrivalStop.name] Frame:CGRectMake(10, j * cellHight, 280, cellHight)];

                routeLabel.numberOfLines = 2;
                [self.detailContainer addSubview:routeLabel];

                if (buscount < self.transit.segments.count - 1) {
                    UIImageView *dotView = [self createUIImageViewWithImage:[UIImage imageNamed:@"g_line_x"] Frame:CGRectMake(0, (j + 1) * cellHight, 300, 1)];
                    ;
                    [self.detailContainer addSubview:dotView];
                }
            }
        }
        break;
    }
    }

    _scrollView.contentSize = CGSizeMake(0, self.detailContainer.frame.origin.y + self.detailContainer.frame.size.height);
}

- (UILabel *)createUILabelWithContent:(NSString *)newContent
                                Frame:(CGRect)newFrame {

    UILabel *newLabel = [[UILabel alloc] init];

    if (newContent != nil) {
        newLabel.text = newContent;
    }

    newLabel.frame = (!CGRectIsEmpty(newFrame)) ? newFrame : CGRectMake(10.0, 5.0, 300.0, 24.0);
    newLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    newLabel.textColor = [UIColor grayColor];
    newLabel.backgroundColor = [UIColor clearColor];
    newLabel.textAlignment = NSTextAlignmentLeft;
    newLabel.lineBreakMode = NSLineBreakByTruncatingTail;

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:newContent];

    NSRange range = [newContent rangeOfString:@"[\\d\\.]+" options:NSRegularExpressionSearch];
    while (range.location != NSNotFound) {
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#cc0000"] range:range];

        range = [newContent rangeOfString:@"[\\d\\.]+" options:NSRegularExpressionSearch range:NSMakeRange(range.location + range.length, newContent.length - range.location - range.length)];
    }
    newLabel.attributedText = str;

    return newLabel;
}

- (UIImageView *)createUIImageViewWithImage:(UIImage *)newImage Frame:(CGRect)newFrame {
    UIImageView *imageView = [[UIImageView alloc] init];
    if (newImage) {
        imageView.image = newImage;
    }
    imageView.frame = newFrame;
    return imageView;
}
@end
