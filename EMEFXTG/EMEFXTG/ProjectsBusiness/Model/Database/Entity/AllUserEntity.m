//
//  AllUserEntity.m
//  EMESHT
//
//  Created by appeme on 15/2/10.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "AllUserEntity.h"
#import "EntityHelper.h"
#import "Login.h"
#import "ChineseToPinyin.h"

@implementation AllUserEntity
- (NSDictionary *)queryAttributes {
    static dispatch_once_t onceToken;
    static NSDictionary *dictionary;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:[EntityHelper queryAttributes:self.class]];
        [mutableDictionary removeObjectForKey:@"description"];
        [mutableDictionary removeObjectForKey:@"debugDescription"];
        [mutableDictionary removeObjectForKey:@"user"];
        [mutableDictionary removeObjectForKey:@"pinyin"];
        [mutableDictionary removeObjectForKey:@"pinyinAbbr"];
        dictionary = [mutableDictionary copy]; });
    return dictionary;
}

- (void)prepareFromData {
    _user = [[Login alloc] initWithString:_userString error:nil];

    NSMutableString *mString = [NSMutableString string];
    NSMutableString *mStringAbbr = [NSMutableString string];
    NSRange range;
    for (int i = 0; i < _user.name.length; i += range.length) {
        range = [_user.name rangeOfComposedCharacterSequenceAtIndex:i];
        NSString *s = [_user.name substringWithRange:range];
        s = [ChineseToPinyin pinyinFromChiniseString:s];
        if (s.length > 0) {
            s = [s lowercaseString];
            [mString appendString:s];

            range = [s rangeOfComposedCharacterSequenceAtIndex:0];
            if (range.length > 0) {
                [mStringAbbr appendString:[s substringWithRange:range]];
            }
        }
    }

    self.pinyin = mString;
    self.pinyinAbbr = mStringAbbr;
}
@end
