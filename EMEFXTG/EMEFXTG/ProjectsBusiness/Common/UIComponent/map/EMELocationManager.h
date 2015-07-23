
#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
static NSString *const EMELocationDidUpdateNotification = @"EMELocationDidUpdateNotification";
static NSString *const EMELocationDidFailNotification = @"EMELocationDidFailNotification";

static NSString *const EMELocationDidUpdateChinaNotification = @"EMELocationDidUpdateChinaNotification";
static NSString *const EMELocationDidUpdatChinaFailNotification = @"EMELocationDidUpdatChinaFailNotification";

static NSString *const EMELocationDidFindCityName = @"EMELocationDidFindCityName";
static NSString *const EMELocationCantParseCityName = @"EMELocationCantParseCityName";

static NSString *const EMELocationFindAddressDetailSuccess = @"EMELocationFindAddressDetailSuccess";
static NSString *const EMELocationFindAddressDetailFail = @"EMELocationFindAddressDetailFail";

@protocol EMELocationDelegate <NSObject>

@optional

- (void)locationdidUpdateChinaLongitude:(double)aLongitude chinaLatitude:(double)aLatitude;
- (void)locationdidUpdateChinaFailWithError:(NSError *)error;
- (void)locationdidUpdateLongitude:(double)aLongitude Latitude:(double)aLatitude;
- (void)locationdidUpdateFailWithError:(NSError *)error;

@end

@interface EMELocationManager : NSObject <UIAlertViewDelegate, MAMapViewDelegate, AMapSearchDelegate> {

    BOOL firstLocate;
    double tmpLatitude;
    double tmpLongitude;
    NSString *address;
    NSString *city;
}

@property (readonly) double tmpLatitude;
@property (readonly) double tmpLongitude;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) id<EMELocationDelegate> locationDelegate;
+ (EMELocationManager *)sharedLocationManager;
+ (void)destroyInstance;

- (void)weakup;

- (void)sleep;

@end
