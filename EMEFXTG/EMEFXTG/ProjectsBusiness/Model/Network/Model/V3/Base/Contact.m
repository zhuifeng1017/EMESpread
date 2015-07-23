//
//  Contact.m
//  EMESHT
//
//  Created by appeme on 14-11-11.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "Contact.h"

#pragma mark - Base
@implementation Contact
@end
@implementation MyContactBase
@end
@implementation MyContact
@end

#pragma mark - Request
@implementation SaveContactRequest
- (NSString *)requestMethod {
    return @"contact/save";
}
@end

@implementation GetContactRequest
- (NSString *)requestMethod {
    return @"contact/get";
}
@end

@implementation UpdateContactRequest
- (NSString *)requestMethod {
    return @"contact/update";
}
@end

@implementation DeleteContactRequest
- (NSString *)requestMethod {
    return @"contact/delete";
}
@end

@implementation ImportContactRequest
- (NSString *)requestMethod {
    return @"contact/import";
}
@end
