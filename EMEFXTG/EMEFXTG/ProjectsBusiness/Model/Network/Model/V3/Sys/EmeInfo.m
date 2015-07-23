//
//  EmeInfo.m
//  EMEHS-MGT
//
//  Created by appeme on 14-9-4.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "EmeInfo.h"

@implementation EmeInfo

@end

@implementation SaveEmeInfoRequest
- (NSString *)requestMethod {
    return @"websys/saveEmeInfo";
}
@end

@implementation GetEmeInfoRequest
- (NSString *)requestMethod {
    return @"sys/getEmeInfo";
}
@end