//
//  BaseMapViewController.h
//  autonaviDemo
//
//  Created by appeme on 14-8-18.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface MapViewController : UIViewController <MAMapViewDelegate, AMapSearchDelegate>

@property AMapSearchType searchType;
@property BOOL fromDetail; //路线查询时间来自路线列表页
@property (weak, nonatomic) IBOutlet UIView *mapContainer;
@property (weak, nonatomic) IBOutlet UIView *buttonContainer;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (weak, nonatomic) IBOutlet UIView *bottomContainer;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonCar;
@property (weak, nonatomic) IBOutlet UIButton *buttonBus;
@property (weak, nonatomic) IBOutlet UIButton *buttonWalk;
@property (weak, nonatomic) IBOutlet UIButton *followMeButton;

/**
 *  @param param key=city,address,company
 */
- (void)putDestinationInfo:(NSDictionary *)param;

- (IBAction)carClick:(id)sender;
- (IBAction)busClick:(id)sender;
- (IBAction)walkClick:(id)sender;
- (IBAction)detailClick:(id)sender;
- (IBAction)zoomInClick:(id)sender;
- (IBAction)zoomOutClick:(id)sender;
- (IBAction)followMeClick:(id)sender;

@end
