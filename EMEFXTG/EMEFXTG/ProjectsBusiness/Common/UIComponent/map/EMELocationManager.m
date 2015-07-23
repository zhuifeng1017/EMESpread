
#import "EMELocationManager.h"

@interface EMELocationManager ()
@property (nonatomic, strong) MAMapView *mapView;
@end

@implementation EMELocationManager

@synthesize tmpLatitude;
@synthesize tmpLongitude;
@synthesize locationDelegate;
@synthesize address;
@synthesize city;
static EMELocationManager *sharedLocationManager = nil;
static BOOL isNoPositionShow = NO;

+ (EMELocationManager *)sharedLocationManager {
    @synchronized(self) {
        if (sharedLocationManager == nil) {
            sharedLocationManager = [[self alloc] init];
            isNoPositionShow = NO;
        }
        return sharedLocationManager;
    }
}

+ (void)destroyInstance {
    if (sharedLocationManager) {
        sharedLocationManager = nil;
    }
}

- (id)init {
    if (self = [super init]) {
        firstLocate = YES;

        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];

        _mapView.distanceFilter = 5.0;

        _mapView.desiredAccuracy = kCLLocationAccuracyBest;

        _mapView.delegate = self;
    }
    return self;
}

- (void)weakup {
    _mapView.showsUserLocation = YES;

    if ([FWUICommon isSimulator]) {
        tmpLatitude = 31.2;
        tmpLongitude = 121.3;
        [EMELocationManager sharedLocationManager].city = @"上海市";
        [[NSNotificationCenter defaultCenter] postNotificationName:EMELocationDidUpdateNotification object:nil];
    }
}

- (void)sleep {
    _mapView.showsUserLocation = NO;
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation NS_AVAILABLE(NA, 4_0) {

    NSTimeInterval locationAge = -[userLocation.location.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0 && !firstLocate)
        return;
    firstLocate = NO;

    tmpLatitude = userLocation.location.coordinate.latitude;
    tmpLongitude = userLocation.location.coordinate.longitude;
    [[NSNotificationCenter defaultCenter] postNotificationName:EMELocationDidUpdateNotification object:nil];

    if (locationDelegate != nil && [locationDelegate conformsToProtocol:@protocol(EMELocationDelegate)] && [locationDelegate respondsToSelector:@selector(locationdidUpdateLongitude:Latitude:)]) {
        [locationDelegate locationdidUpdateLongitude:tmpLongitude Latitude:tmpLatitude];
    }
}
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error NS_AVAILABLE(NA, 4_0) {
    if (error.code == kCLErrorDenied) {
        [self performSelector:@selector(showLocationErrorAlert) withObject:nil afterDelay:3.f];
    }
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
}

- (void)showLocationErrorAlert {
    if (!isNoPositionShow) {
        isNoPositionShow = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位失败" message:@"请开启“设置->定位服务”中的相关选项。" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
        //        [self sleep];
    }
}

@end
