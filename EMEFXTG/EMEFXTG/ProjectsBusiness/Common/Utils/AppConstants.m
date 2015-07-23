//
//  AppConstants.m
//  EMESHT
//
//  Created by xuanhr on 14-11-26.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "AppConstants.h"

@implementation AppConstants
+ (NSDictionary *)getSmilieDictionary {
    static NSDictionary *smilies = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        smilies =  @{ @"expression01" : @"口渴",
                      @"expression02" : @"流汗",
                      @"expression03" : @"惊恐",
                      @"expression04" : @"微笑",
                      @"expression05" : @"流口水",
                      @"expression06" : @"大笑",
                      @"expression07" : @"疑惑",
                      @"expression08" : @"可爱",
                      @"expression09" : @"喜爱",
                      @"expression10" : @"暴怒",
                      @"expression11" : @"流泪",
                      @"expression12" : @"酷炫",
                      @"expression13" : @"烧焦",
                      @"expression14" : @"愤怒"
                      };
    });
    return smilies;
}
@end
