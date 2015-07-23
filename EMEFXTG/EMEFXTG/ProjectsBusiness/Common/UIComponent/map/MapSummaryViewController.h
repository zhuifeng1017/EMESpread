//
//  MapSummaryViewController.h
//  EMEHS
//
//  Created by Mac on 14-8-19.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface MapSummaryViewController : UIViewController
@property (nonatomic, strong) AMapPath *path;
@property (nonatomic, strong) AMapTransit *transit;
@property (nonatomic, strong) NSDictionary *paramDic;
@property (nonatomic, assign) AMapSearchType searchType;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *detailContainer;
@end
