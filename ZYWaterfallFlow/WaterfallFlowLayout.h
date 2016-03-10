//
//  WaterfallFlowLayout.h
//  WaterfallFlowDemo
//
//  Created by Daniel on 16/3/9.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGFloat(^HeightBlock)(NSIndexPath *indexPath, CGFloat width);

@interface WaterfallFlowLayout : UICollectionViewLayout

// 行间距
@property (nonatomic,assign) NSInteger rowSpaceing;
// 列间距
@property (nonatomic,assign) NSInteger lineSpaceing;
// 列数
@property (nonatomic,assign) NSInteger lineNum;
// collectionView边距
@property (nonatomic,assign) UIEdgeInsets sectionInset;

- (void)setCellHeightWithBlock:(HeightBlock)block;

@end
