//
//  BaseMapViewController.m
//  autonaviDemo
//
//  Created by appeme on 14-8-18.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "MapViewController.h"
#import "EMELocationManager.h"
#import "MBProgressHUD.h"
#import "CommonUtility.h"
#import "LineDashPolyline.h"
#import "MapSummaryViewController.h"
#import "AppDelegate.h"
#import "UIColor+HexString.h"
#import "MMProgressHUD.h"

#define MAPAPIKey @"7df4a522cfdd7bd2ce23ea35ea6ebcac"

const NSString *BaseMapStartTitle = @"起点";
const NSString *BaseMapDestinationTitle = @"终点";
const NSString *BaseMapCarTitle = @"当前位置";

@interface MapViewController ()
@property (nonatomic, strong) NSMutableDictionary *paramDic;
/* 起始点经纬度. */
@property (nonatomic) CLLocationCoordinate2D startCoordinate;
/* 终点经纬度. */
@property (nonatomic) CLLocationCoordinate2D destinationCoordinate;
@property (nonatomic, strong) AMapRoute *route;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, strong) MAPointAnnotation *carAnnotation;
@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [MAMapServices sharedServices].apiKey = MAPAPIKey;
    }
    return self;
}

- (void)configureMap {
    self.startCoordinate = CLLocationCoordinate2DMake(0, 0); // ShangHai lat,lon (31.2,121.3-7)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationUpdated) name:EMELocationDidUpdateNotification object:nil];

    self.mapView = [[MAMapView alloc] initWithFrame:self.mapContainer.bounds];
    self.mapView.delegate = self;
    self.mapView.showsScale = NO;
    self.mapView.zoomEnabled = YES;
    self.mapView.zoomLevel = 15;
    [self.mapContainer addSubview:self.mapView];

    [[EMELocationManager sharedLocationManager] weakup];

    self.search = [[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"地图导航";

    [self configureMap];
    [self parseAddressTogeo];
}

- (void)locationUpdated {
    self.startCoordinate = CLLocationCoordinate2DMake([[EMELocationManager sharedLocationManager] tmpLatitude], [[EMELocationManager sharedLocationManager] tmpLongitude]);

    if (self.startCoordinate.latitude == 0) {
        //    self.destinationCoordinate = CLLocationCoordinate2DMake(31.2, 121.5);
        [self requestAddress];
    } else {
        if (!_carAnnotation) {
            [self addCarAnnotations];

            // if hasn't destinationCoordinate then use startCoordinate as map center
            if (self.destinationCoordinate.latitude == 0) {
                [self moveCarToCenter];
            }
        }
        _carAnnotation.coordinate = self.startCoordinate;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)putDestinationInfo:(NSDictionary *)param {
    _paramDic = [NSMutableDictionary dictionaryWithDictionary:param];
}

- (IBAction)carClick:(id)sender {
    self.searchType = AMapSearchType_NaviDrive;
    [self searchNaviWithType:self.searchType];

    [self setButtonSelection:sender];
}

- (IBAction)busClick:(id)sender {
    self.searchType = AMapSearchType_NaviBus;
    [self searchNaviWithType:self.searchType];

    [self setButtonSelection:sender];
}

- (IBAction)walkClick:(id)sender {
    self.searchType = AMapSearchType_NaviWalking;
    [self searchNaviWithType:self.searchType];

    [self setButtonSelection:sender];
}

- (void)setButtonSelection:(UIButton *)button {
    self.buttonCar.selected = button == self.buttonCar;
    self.buttonBus.selected = button == self.buttonBus;
    self.buttonWalk.selected = button == self.buttonWalk;
}

- (IBAction)zoomInClick:(id)sender {
    [self.mapView setZoomLevel:self.mapView.zoomLevel + 1 animated:YES];
}

- (IBAction)zoomOutClick:(id)sender {
    [self.mapView setZoomLevel:self.mapView.zoomLevel - 1 animated:YES];
}

- (IBAction)followMeClick:(id)sender {
    if (!self.followMeButton.selected) {
        [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
        self.followMeButton.selected = YES;
    } else {
        [self.mapView setUserTrackingMode:MAUserTrackingModeNone animated:YES];
        self.followMeButton.selected = NO;
    }

    if (self.mapView.userTrackingMode == MAUserTrackingModeFollow && !self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    }
}

- (void)moveCarToCenter {
    _carAnnotation.coordinate = self.startCoordinate;
    [self.mapView setCenterCoordinate:self.startCoordinate animated:YES];
}

- (void)timerFired {
    if (self.followMeButton.selected) {
        [self moveCarToCenter];
    }
}

/* 根据searchType来执行响应的导航搜索*/
- (void)searchNaviWithType:(AMapSearchType)type {
    static double lastTimeSearch;
    double currentTime = [[NSDate date] timeIntervalSince1970];

    if (fabs(lastTimeSearch - currentTime) <= 1.5f) {
        return;
    }
    lastTimeSearch = currentTime;

    if (self.startCoordinate.latitude == 0) {
        return;
    }
    [self clear];

    switch (type) {
    case AMapSearchType_NaviDrive: {
        [self searchNaviDrive];
        break;
    }
    case AMapSearchType_NaviWalking: {
        [self searchNaviWalk];
        break;
    }
    default:
    AMapSearchType_NaviBus : {
        [self searchNaviBus];
        break;
    }
    }
}

/* 驾车导航搜索. */
- (void)searchNaviDrive {
    AMapNavigationSearchRequest *navi = [[AMapNavigationSearchRequest alloc] init];
    navi.searchType = AMapSearchType_NaviDrive;
    navi.requireExtension = YES;

    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
                                           longitude:self.startCoordinate.longitude];
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
                                                longitude:self.destinationCoordinate.longitude];

    [self.search AMapNavigationSearch:navi];
    [self showLoadingView];
}

- (void)showLoadingView {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithTitle:nil status:@"获取线路..." confirmationMessage:@"点击停止" cancelBlock:^{}];
}

- (void)removeLoadingView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MMProgressHUD dismiss];
    });
}

- (void)dealloc {
    [self removeLoadingView];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [self clear];
}

#pragma mark - 详情
- (IBAction)detailClick:(id)sender {
    if (self.route == nil) {
        return;
    }

    [self gotoDetailForRoute:self.route type:self.searchType];
}
/**
 * 进入详情页面
 */
- (void)gotoDetailForRoute:(AMapRoute *)route type:(AMapSearchType)type {
    if (self.searchType == AMapSearchType_NaviBus) {
        [self gotoDetailForTransit:self.route.transits[0]];
    }
    /* 步行, 驾车方案. */
    else {
        [self gotoDetailForPath:self.route.paths[0]];
    }
}

- (void)gotoDetailForPath:(AMapPath *)path {
    MapSummaryViewController *pathDetailVC = [[MapSummaryViewController alloc] init];
    pathDetailVC.path = path;
    pathDetailVC.paramDic = _paramDic;
    pathDetailVC.searchType = self.searchType;
    [self presentViewController:pathDetailVC animated:YES completion:nil];
}

- (void)gotoDetailForTransit:(AMapTransit *)transit {
    MapSummaryViewController *pathDetailVC = [[MapSummaryViewController alloc] init];
    pathDetailVC.transit = transit;
    pathDetailVC.paramDic = _paramDic;
    pathDetailVC.searchType = self.searchType;
    [self presentViewController:pathDetailVC animated:YES completion:nil];
}

#pragma mark - 根据地址获取经纬度 - 取终点
- (void)parseAddressTogeo {
    if (![[_paramDic objectForKey:@"address"] isEqualToString:@""]) {
        AMapGeocodeSearchRequest *geoRequest = [[AMapGeocodeSearchRequest alloc] init];
        geoRequest.searchType = AMapSearchType_Geocode;
        geoRequest.address = [_paramDic objectForKey:@"address"];
        [self.search AMapGeocodeSearch:geoRequest];
    }
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response {
    if (response.geocodes.count > 0) {
        AMapGeocode *p = [response.geocodes objectAtIndex:0];
        self.destinationCoordinate = CLLocationCoordinate2DMake(p.location.latitude, p.location.longitude);
        if (![p.city isEqualToString:@""]) {
            [_paramDic setValue:p.city forKey:@"city"];
        } else if (![p.province isEqualToString:@""]) {
            [_paramDic setValue:p.province forKey:@"city"];
        }
    }

    [self addDefaultAnnotations];
}

#pragma mark - 根据经纬度获取城市及地址
- (void)requestAddress {
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];

    regeo.location = [AMapGeoPoint locationWithLatitude:[EMELocationManager sharedLocationManager].tmpLatitude longitude:[EMELocationManager sharedLocationManager].tmpLongitude];
    regeo.requireExtension = YES;

    [self.search AMapReGoecodeSearch:regeo];
}

/**
 *  逆地理编码回调
 */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    if (response.regeocode != nil) {
        AMapReGeocode *geo = response.regeocode;
        [EMELocationManager sharedLocationManager].address = [geo formattedAddress];
        AMapAddressComponent *cityComponent = geo.addressComponent;
        if (cityComponent.city && ![cityComponent.city isEqualToString:@""]) {
            [EMELocationManager sharedLocationManager].city = cityComponent.city;

        } else {
            [EMELocationManager sharedLocationManager].city = cityComponent.province;
        }
    }
}

/**
 * 插起点，终点
 */
- (void)addDefaultAnnotations {
    self.startCoordinate = CLLocationCoordinate2DMake([[EMELocationManager sharedLocationManager] tmpLatitude], [[EMELocationManager sharedLocationManager] tmpLongitude]);
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    startAnnotation.coordinate = self.startCoordinate;
    startAnnotation.title = (NSString *)BaseMapStartTitle;
    startAnnotation.subtitle = [NSString stringWithFormat:@"{%f, %f}", self.startCoordinate.latitude, self.startCoordinate.longitude];
    [self.mapView addAnnotation:startAnnotation];

    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.coordinate = self.destinationCoordinate;
    destinationAnnotation.title = (NSString *)BaseMapDestinationTitle;
    destinationAnnotation.subtitle = [NSString stringWithFormat:@"{%f, %f}", self.destinationCoordinate.latitude, self.destinationCoordinate.longitude];

    [self.mapView setCenterCoordinate:self.destinationCoordinate animated:YES];
    [self.mapView addAnnotation:destinationAnnotation];
}

/**
 * 添加小车的位置
 */
- (void)addCarAnnotations {
    _carAnnotation = [[MAPointAnnotation alloc] init];
    _carAnnotation.coordinate = self.startCoordinate;
    _carAnnotation.title = (NSString *)BaseMapCarTitle;
    _carAnnotation.subtitle = [NSString stringWithFormat:@"{%f, %f}", self.startCoordinate.latitude, self.startCoordinate.longitude];
    [self.mapView addAnnotation:_carAnnotation];
}

#pragma mark - MAMapViewDelegate

- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay {
    UIColor *lineColor = [[UIColor colorWithHexString:@"#3333ff"] colorWithAlphaComponent:.8];
    if ([overlay isKindOfClass:[LineDashPolyline class]]) {
        MAPolylineView *overlayView = [[MAPolylineView alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];

        overlayView.lineWidth = 4;
        overlayView.strokeColor = lineColor;
        overlayView.lineDashPattern = @[ @5, @10 ];

        return overlayView;
    }

    if ([overlay isKindOfClass:[MAPolyline class]]) {
        MAPolylineView *overlayView = [[MAPolylineView alloc] initWithPolyline:overlay];

        overlayView.lineWidth = 4;
        overlayView.strokeColor = lineColor;

        return overlayView;
    }

    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *navigationCellIdentifier = @"navigationCellIdentifier";

        MAAnnotationView *poiAnnotationView = (MAAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:navigationCellIdentifier];
        if (poiAnnotationView == nil) {
            poiAnnotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:navigationCellIdentifier];
        }

        poiAnnotationView.canShowCallout = YES;

        if ([[annotation title] isEqualToString:(NSString *)BaseMapStartTitle]) {
            poiAnnotationView.image = [UIImage imageNamed:@"page_map_icon_start"];
        } else if ([[annotation title] isEqualToString:(NSString *)BaseMapDestinationTitle]) {
            poiAnnotationView.image = [UIImage imageNamed:@"page_map_icon_end"];
        } else if ([[annotation title] isEqualToString:(NSString *)BaseMapCarTitle]) {
            poiAnnotationView.image = [UIImage imageNamed:@"dt_biaoji"];
        }

        return poiAnnotationView;
    }

    return nil;
}

#pragma mark - AMapSearchDelegate
/**
 *  导航搜索回调
 */
- (void)onNavigationSearchDone:(AMapNavigationSearchRequest *)request
                      response:(AMapNavigationSearchResponse *)response {
    [self removeLoadingView];
    if (self.searchType != request.searchType) {
        return;
    }

    if (response.route == nil) {

        [self presentTopView];
        return;
    }

    self.route = response.route;

    [self presentCurrentCourse];
    //
    //        if (fromDetail) {
    //            fromDetail = NO;
    //            if (self.searchType == AMapSearchType_NaviBus){
    //                //            [[NSNotificationCenter defaultCenter]postNotificationName:EME_UPDATE_PATHDETAIL_VIEW object:self.route.transits[0]];
    //            }else{
    //                //            [[NSNotificationCenter defaultCenter]postNotificationName:EME_UPDATE_PATHDETAIL_VIEW object:self.route.paths[0]];
    //            }
    //        }
}

#pragma mark - Navigation Search

/**
 *  公交导航搜索
 */
- (void)searchNaviBus {
    if ([self validateSameCity]) {
        AMapNavigationSearchRequest *navi = [[AMapNavigationSearchRequest alloc] init];
        navi.searchType = AMapSearchType_NaviBus;
        navi.requireExtension = YES;
        navi.city = [_paramDic objectForKey:@"city"];

        /* 出发点. */
        navi.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
                                               longitude:self.startCoordinate.longitude];
        /* 目的地. */
        navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
                                                    longitude:self.destinationCoordinate.longitude];

        [self.search AMapNavigationSearch:navi];

        [self showLoadingView];
    } else {
        //        self.summaryLabel.alpha = 0;
        //        _bottomBtnView.alpha = 0;

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"公交只支持同城查询" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

/**
 *  步行导航搜索
 */
- (void)searchNaviWalk {
    if ([self validateSameCity]) {
        AMapNavigationSearchRequest *navi = [[AMapNavigationSearchRequest alloc] init];
        navi.searchType = AMapSearchType_NaviWalking;
        navi.requireExtension = YES;

        /* 出发点. */
        navi.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
                                               longitude:self.startCoordinate.longitude];
        /* 目的地. */
        navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
                                                    longitude:self.destinationCoordinate.longitude];

        [self.search AMapNavigationSearch:navi];

        [self showLoadingView];
    } else {
        //        self.summaryLabel.alpha = 0;
        //        _bottomBtnView.alpha = 0;

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"步行只支持同城查询" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

/**
 *  终点城市是否是定位城市
 *
 *  @return 是否是同一个地址
 */
- (BOOL)validateSameCity {
    NSString *locateCity = [EMELocationManager sharedLocationManager].city;
    if (![locateCity hasSuffix:@"市"]) {
        locateCity = [NSString stringWithFormat:@"%@市", locateCity];
    }
    NSString *dbCity = [_paramDic objectForKey:@"city"];
    //如果没有输入城市，则默认为定位城市
    if ([dbCity isEqualToString:@""]) {
        dbCity = locateCity;
    }
    if (![dbCity hasSuffix:@"市"]) {
        dbCity = [NSString stringWithFormat:@"%@市", dbCity];
    }
    if ([locateCity isEqualToString:dbCity]) {
        return YES;
    }
    return YES; //DRAFT alway return YES
}

#pragma mark - AMapSearchDelegate

- (void)search:(id)searchRequest error:(NSString *)errInfo {
    [MMProgressHUD dismissWithError:@"请检查网络！"];
}

/**
 *  展示当前路线方案
 */
- (void)presentCurrentCourse {
    NSArray *polylines = nil;

    if (self.searchType == AMapSearchType_NaviBus) {
        // 公交导航.
        polylines = [CommonUtility polylinesForTransit:self.route.transits[0]];
    } else {
        // 步行，驾车导航.
        polylines = [CommonUtility polylinesForPath:self.route.paths[0]];
    }
    [self.mapView addOverlays:polylines];

    MAMapRect mapRect = [CommonUtility mapRectForOverlays:polylines];
    [self fitMapRect:&mapRect];

    [self.mapView setVisibleMapRect:mapRect animated:YES];

    [self presentTopView];
}

- (void)presentTopView {
    _bottomContainer.alpha = 1;

    if (self.searchType == AMapSearchType_NaviBus) {
        if ([self.route.transits count] > 0) {
            AMapTransit *transite = [self.route.transits objectAtIndex:0];

            NSDictionary *d = [self.class dicConvertToFriendlyStringWithSecond:transite.duration];
            NSString *hour = [d objectForKey:@"hour"];
            NSString *minute = [d objectForKey:@"minute"];
            NSString *hourString = hour.length > 0 ? [NSString stringWithFormat:@"%@小时", hour] : @"";
            NSString *minuteString = minute.length > 0 ? [NSString stringWithFormat:@"%@分钟", minute] : @"";
            NSString *distance = [self.class formattedDistance:transite.walkingDistance];

            NSMutableString *tmpString = [NSMutableString new];

            if (distance.length > 0) {
                [tmpString appendFormat:@"需步行%@", distance];
            }

            if (hourString.length + minuteString.length > 0) {
                [tmpString appendString:@",用时"];
            }
            if (hourString.length > 0) {
                [tmpString appendFormat:@"%@", hourString];
            }
            if (minuteString.length > 0) {
                [tmpString appendFormat:@"%@", minuteString];
            }

            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:tmpString];

            NSRange range = [tmpString rangeOfString:@"[\\d\\.]+" options:NSRegularExpressionSearch];
            while (range.location != NSNotFound) {
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];

                range = [tmpString rangeOfString:@"[\\d\\.]+" options:NSRegularExpressionSearch range:NSMakeRange(range.location + range.length, tmpString.length - range.location - range.length)];
            }
            self.summaryLabel.attributedText = str;
        }

    } else {
        self.summaryLabel.alpha = 1;
        if (self.route.paths.count > 0) {
            AMapPath *path = [self.route.paths objectAtIndex:0];

            NSDictionary *d = [self.class dicConvertToFriendlyStringWithSecond:path.duration];
            NSString *hour = [d objectForKey:@"hour"];
            NSString *minute = [d objectForKey:@"minute"];
            NSString *hourString = hour.length > 0 ? [NSString stringWithFormat:@"%@小时", hour] : @"";
            NSString *minuteString = minute.length > 0 ? [NSString stringWithFormat:@"%@分钟", minute] : @"";
            NSString *distance = [self.class formattedDistance:path.distance];

            NSMutableString *tmpString = [NSMutableString new];

            if (distance.length > 0) {
                [tmpString appendFormat:@"共%@", distance];
            }

            if (hourString.length + minuteString.length > 0) {
                [tmpString appendString:@",用时"];
            }
            if (hourString.length > 0) {
                [tmpString appendFormat:@"%@", hourString];
            }
            if (minuteString.length > 0) {
                [tmpString appendFormat:@"%@", minuteString];
            }

            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:tmpString];

            NSRange range = [tmpString rangeOfString:@"[\\d\\.]+" options:NSRegularExpressionSearch];
            while (range.location != NSNotFound) {
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];

                range = [tmpString rangeOfString:@"[\\d\\.]+" options:NSRegularExpressionSearch range:NSMakeRange(range.location + range.length, tmpString.length - range.location - range.length)];
            }
            self.summaryLabel.attributedText = str;
        }
    }
}

- (void)fitMapRect:(MAMapRect *)mapRect {
    int height = mapRect->size.height;
    int width = mapRect->size.width;
    mapRect->origin.x -= width * 0.1f;
    mapRect->size.width += width * 0.2f;
    mapRect->origin.y -= width * 0.1f;
    mapRect->size.height += height * 0.2f;
}

/**
 *  清空地图上的overlay
 */
- (void)clear {
    self.route = nil;
    [self.mapView removeOverlays:self.mapView.overlays];
}

/**
 * 释放timer
 */
- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [super dismissViewControllerAnimated:flag completion:completion];
    [self.timer invalidate];
}

#pragma mark - common method
+ (NSString *)formattedDistance:(int)distance {
    if (distance / 1000.0 > 1 && distance / 1000.0 <= 100) {
        return [NSString stringWithFormat:@"%2.1f公里", distance / 1000.0];
    } else if (distance <= 1000) {
        return [NSString stringWithFormat:@"%0.0d米", distance];
    } else if (distance / 1000.0 > 100) {
        NSString *s = [NSString stringWithFormat:@"%f", distance / 1000.0];
        return [NSString stringWithFormat:@"%d公里", [s intValue]];
    } else {
        return @"";
    }
}

//转换秒为  x小时x分钟x秒模式 isUTC = YES 时间显示为 23:59:59
+ (NSDictionary *)dicConvertToFriendlyStringWithSecond:(NSInteger)second {
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
    NSInteger hours = (NSInteger)(floorf(second / (60 * 60.0)));
    NSInteger minutes = ((NSInteger)floorf(second / 60.0)) % 60;

    if (hours > 0) {
        [resultDic setObject:[NSString stringWithFormat:@"%d", hours] forKey:@"hour"];
    }
    if (minutes > 0) {
        [resultDic setObject:[NSString stringWithFormat:@"%d", minutes] forKey:@"minute"];
    }
    return resultDic;
}

@end
