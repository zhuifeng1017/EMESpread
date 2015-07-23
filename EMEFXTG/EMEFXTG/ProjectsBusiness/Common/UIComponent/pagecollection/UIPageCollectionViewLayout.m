//
//  UIPageCollectionViewLayout.m
//  UICollectionViewDemo
//
//  Created by appeme on 14-8-12.
//  Copyright (c) 2014年 Lee. All rights reserved.
//

#import "UIPageCollectionViewLayout.h"

@implementation UIPageCollectionViewLayout
- (CGSize)collectionViewContentSize {
    float width = self.collectionView.frame.size.width * ([self.collectionView numberOfItemsInSection:0]);
    float height = self.collectionView.frame.size.height;
    CGSize size = CGSizeMake(width, height);
    return size;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

#pragma mark - UICollectionViewLayout
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    float width = self.collectionView.frame.size.width;

    attributes.size = self.collectionView.frame.size;
    attributes.center = CGPointMake(indexPath.row * width + width / 2, attributes.size.height / 2);

    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    if ([arr count] > 0) {
        return arr;
    }
    NSMutableArray *attributes = [NSMutableArray array];
    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}

@end
