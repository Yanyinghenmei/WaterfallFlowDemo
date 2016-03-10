//
//  WaterfallFlowLayout.m
//  WaterfallFlowDemo
//
//  Created by Daniel on 16/3/9.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "WaterfallFlowLayout.h"

@interface WaterfallFlowLayout ()
@property (nonatomic, copy) HeightBlock block;
@property (nonatomic, strong) NSMutableArray *itemAttrsArr; //所有item的属性都保存在这里
@property (nonatomic, strong) NSMutableDictionary *heightSumDic;
@end

@implementation WaterfallFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        _lineNum = _lineNum?_lineNum:3;
        _rowSpaceing = _rowSpaceing?_rowSpaceing:10;
        _lineSpaceing = _lineSpaceing?_lineSpaceing:10;
        _sectionInset = _sectionInset.top?_sectionInset:UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}

// 1.准备布局/布局开始
- (void)prepareLayout {
    _itemAttrsArr = @[].mutableCopy;
    _heightSumDic = @{}.mutableCopy;
    
    for (NSInteger i = 0; i < _lineNum; i++) {
        [_heightSumDic setObject:@(_sectionInset.top) forKey:[NSString stringWithFormat:@"%ld", i]];
    }
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < itemCount; i++) {
        [_itemAttrsArr addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
}

// 2.设置每个item的属性

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    __block NSString *minHeightKey = @"0";
    
    // 遍历
    [_heightSumDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL * _Nonnull stop) {
        if ([_heightSumDic[minHeightKey] doubleValue] > [obj doubleValue]) {
            minHeightKey = key;
        }
    }];
    
    CGFloat itemW = (self.collectionView.bounds.size.width - _sectionInset.left - _sectionInset.right - (_lineNum-1)*_lineSpaceing)/_lineNum;
    CGFloat itemH = _block(indexPath, itemW);
    
    CGFloat itemX = [minHeightKey intValue] * (_lineSpaceing+itemW) + _sectionInset.left;
    CGFloat itemY = [_heightSumDic[minHeightKey] doubleValue];
    
    _heightSumDic[minHeightKey] = @(itemY + itemH + _rowSpaceing);
    
    attr.frame = CGRectMake(itemX, itemY, itemW, itemH);
    return attr;
}
// 3.返回所有item的属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return _itemAttrsArr;
}

- (void)setCellHeightWithBlock:(HeightBlock)block {
    if (!_block) {
        _block = block;
    }
}

// 4.设置可滚动区域
- (CGSize)collectionViewContentSize {
    __block NSString *minHeightKey = @"0";
    [_heightSumDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([_heightSumDic[minHeightKey] doubleValue]>[obj doubleValue]) {
            minHeightKey = key;
        }
    }];
    return CGSizeMake(self.collectionView.bounds.size.width, [_heightSumDic[minHeightKey] doubleValue]);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    NSLog(@"%lf, %lf, %lf, %lf", newBounds.origin.x, newBounds.origin.y, newBounds.size.width, newBounds.size.height);
    return YES;
}


@end
