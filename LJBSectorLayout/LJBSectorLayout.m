//
//  LJBSectorLayout.m
//  LJBSectorLayoutDemo
//
//  Created by CookieJ on 16/3/27.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBSectorLayout.h"

static CGFloat const kLJBSpectorCellMargin = 10;      // cell间距
static NSInteger const kLJBSpectorShowCellCount = 3;  // 屏幕完整显示的cell个数

@implementation LJBSectorLayout

#pragma mark - 布局初始化设置
- (void)prepareLayout {
    
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat width = self.collectionView.frame.size.width / kLJBSpectorShowCellCount - kLJBSpectorCellMargin;
    CGFloat height = self.collectionView.frame.size.height - kLJBSpectorCellMargin * 2;
    self.itemSize = CGSizeMake(width, height);
    
    // 设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - width) * 0.5;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

#pragma mark - 是否需要重新刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    // 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局（默认返回NO）
    return YES;
}


#pragma mark - 所有cell的布局属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    NSArray * attrsArray = [[NSArray alloc] initWithArray:array copyItems:YES];
    
    
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    for ( UICollectionViewLayoutAttributes * attrs in attrsArray ) {
        
        // cell中心与collectionview中心x的间距
        CGFloat delta = attrs.center.x - centerX;
        
        // 角度
        CGFloat rotation = delta / self.collectionView.frame.size.width * (M_PI_4 / 3);
        
        attrs.transform = CGAffineTransformMakeRotation(rotation);
    }
    
    return attrsArray;
}

#pragma mark - 停止滚动时偏移量
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    // 最终显示的矩形框
    CGRect rect;
    rect.origin.x = proposedContentOffset.x;
    rect.origin.y = 0;
    rect.size = self.collectionView.frame.size;
    
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 找出最小的间距
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes * attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    
    // 设置最新的偏移值
    proposedContentOffset.x += minDelta;
    
    return proposedContentOffset;
}


@end
