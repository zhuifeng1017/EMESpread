//
//  FudScheme.m
//  EMESHT
//
//  Created by appeme on 15/3/18.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "FudScheme.h"

@implementation FudScheme
@end

@implementation FudSchemeResourceDescItem
@end

@implementation FudSchemeResource
@end

@implementation FudProject
@end

@implementation FudProjectBuyInfo
@end

#pragma mark - Request
@implementation SaveFudSchemeRequest
- (NSString *)requestMethod {
    return @"fudscheme/save";
}
@end

@implementation UpdateFudSchemeRequest
- (NSString *)requestMethod {
    return @"fudscheme/update";
}
@end

@implementation QueryFudSchemeRequest
- (NSString *)requestMethod {
    return @"fudscheme/query";
}
@end

@implementation DeleteFudSchemeRequest
- (NSString *)requestMethod {
    return @"fudscheme/exit";
}
@end

@implementation PraiseFudSchemeRequest
- (NSString *)requestMethod {
    return @"fudscheme/praise";
}
@end

@implementation SaveFudSchemeResourceRequest
- (NSString *)requestMethod {
    return @"fudscheme/saveResource";
}
@end

@implementation UpdateFudSchemeResourceRequest
- (NSString *)requestMethod {
    return @"fudscheme/updateResource";
}
@end

@implementation DeleteFudSchemeResourceRequest
- (NSString *)requestMethod {
    return @"fudscheme/deleteResource";
}
@end

#pragma mark - FudProject Request
@implementation QueryFudProjectRequest
- (NSString *)requestMethod {
    return @"fudproject/query";
}
@end

@implementation PraiseFudProjectRequest
- (NSString *)requestMethod {
    return @"fudproject/praise";
}
@end

@implementation PayFudProjectRequest
- (NSString *)requestMethod {
    return @"fudproject/pay";
}
@end

@implementation QueryPayFudProjectRequest
- (NSString *)requestMethod {
    return @"fudproject/queryPay";
}
@end

@implementation MyFudSchemeRequest
- (NSString *)requestMethod {
    return @"fudproject/myscheme";
}
@end

@implementation MyFudProjectRequest
- (NSString *)requestMethod {
    return @"fudproject/mypay";
}
@end
