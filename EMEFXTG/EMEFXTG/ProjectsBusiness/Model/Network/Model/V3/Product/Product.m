
//
//  Product.m
//  EMEFXTG
//
//  Created by appeme on 15/7/21.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "Product.h"

@implementation Product

@end

#pragma mark - Reqeuest
@implementation FindProductRequest
- (NSString *)requestMethod {
    return @"product/find";
}
@end