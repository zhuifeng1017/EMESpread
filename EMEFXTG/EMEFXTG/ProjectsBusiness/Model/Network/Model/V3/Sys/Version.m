//
//  version.m
//  EMEHS-MGT
//
//  Created by xuanhr on 14-9-9.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "version.h"

@implementation Version

@end

@implementation FindVersionRequest
- (NSString *)requestMethod {
    return @"sys/findVersion";
}
@end

@implementation SaveVersionRequest
- (NSString *)requestMethod {
    return @"sys/saveVersion";
}
@end

@implementation DeleteVersionRequest
- (NSString *)requestMethod {
    return @"sys/deleteVersion";
}
@end

@implementation CheckVersionRequest
- (NSString *)requestMethod {
    return @"base/upgrade";
}
@end