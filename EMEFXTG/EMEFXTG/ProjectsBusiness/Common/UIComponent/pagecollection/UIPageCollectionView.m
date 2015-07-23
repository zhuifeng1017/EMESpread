//
//  UIPageCollectionView.m
//  UICollectionViewDemo
//
//  Created by appeme on 14-8-12.
//  Copyright (c) 2014年 Lee. All rights reserved.
//

#import "UIPageCollectionView.h"
#import "UIPageCollectionViewLayout.h"

@interface UIPageCollectionView () {
}
@end

@implementation UIPageCollectionView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame collectionViewLayout:[[UIPageCollectionViewLayout alloc] init]]) {
        [self configureDefault];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.collectionViewLayout = [[UIPageCollectionViewLayout alloc] init];
        [self configureDefault];
    }
    return self;
}

- (void)configureDefault {
    self.pagingEnabled = YES;
    self.bounces = NO;
    self.showsHorizontalScrollIndicator = NO;
}

@end
