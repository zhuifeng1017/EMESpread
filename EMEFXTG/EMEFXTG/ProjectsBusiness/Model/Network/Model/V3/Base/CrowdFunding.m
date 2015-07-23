//
//  CrowdFunding.m
//  EMESHT
//
//  Created by xuanhr on 15/1/22.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "CrowdFunding.h"

@implementation CrowdFunding

@end
@implementation SaveCrowdFundingRequest
- (NSString *)requestMethod {
    return @"project/save";
}
@end

@implementation UpdateCrowdFundingRequest
- (NSString *)requestMethod {
    return @"project/update";
}
@end

@implementation QueryCrowdFundingRequest
- (NSString *)requestMethod {
    return @"project/query";
}
@end

@implementation DeleteCrowdFundingRequest
- (NSString *)requestMethod {
    return @"project/delete";
}
@end
