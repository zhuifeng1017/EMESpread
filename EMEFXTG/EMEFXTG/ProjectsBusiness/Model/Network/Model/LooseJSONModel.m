//
//  LooseJSONModel.m
//  EMEHS-MGT
//
//  Created by appeme on 14-9-5.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

@implementation LooseJSONModel
+ (void)load {
    [JSONModel setGlobalKeyMapper:[
                                      [JSONKeyMapper alloc] initWithDictionary:@{
                                          @"newPassword" : @"aNewPassword",
                                          @"newPrice" : @"aNewPrice",
                                          @"newP" : @"aNewP"
                                      }]];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

- (NSString *)requestMethod {
    @throw @"Please implements requestMethod in your class";

    return nil;
}
@end
