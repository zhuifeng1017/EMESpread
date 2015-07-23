//
//  UITextField+EME.m
//  EMEFXTG
//
//  Created by apple on 15/7/23.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "UITextField+EME.h"
#import <objc/runtime.h>

static char PLACE_HOLDER_COLOR_KEY;

@implementation UITextField (EME)

@dynamic placeholderColorKey;

- (NSString *)placeholderColorKey {
    return (NSString *)objc_getAssociatedObject(self, &PLACE_HOLDER_COLOR_KEY);
}

- (void)setPlaceholderColorKey:(NSString *)color {
    objc_setAssociatedObject(self, &PLACE_HOLDER_COLOR_KEY, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (color) {
        UIColor *clr = [UIColor colorWithHexString:color];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName : clr}];
    }
}

@end
