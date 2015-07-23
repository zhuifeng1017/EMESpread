//
//  Content.m
//  EMEZL
//
//  Created by apple on 15/4/24.
//  Copyright (c) 2015年 appeme. All rights reserved.
//

#import "Content.h"


@implementation Content
@end

@implementation SaveContent
@end


#pragma mark - Request
@implementation SaveContentRequest
- (NSString *)requestMethod {
    return @"product/save";
}
@end