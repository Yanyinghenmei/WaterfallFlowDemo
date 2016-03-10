//
//  ViewController.m
//  WaterfallFlowDemo
//
//  Created by Daniel on 16/3/7.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

#import "WaterfallFlowLayout.h"
#import "TabViewController.h"


static NSString * const kIdentifierCell = @"BQCollectionViewCell";

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) WaterfallFlowLayout *waterLayout;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
#pragma mark - 实例方法

- (void)initUI{
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource Method
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifierCell forIndexPath:indexPath];
    cell.userInteractionEnabled = YES;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self presentViewController:[TabViewController new] animated:YES completion:nil];
}

#pragma mark - get方法
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:self.waterLayout];
        _collectionView.backgroundColor = [UIColor cyanColor];
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:kIdentifierCell];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}
- (WaterfallFlowLayout *)waterLayout {
    if (_waterLayout == nil) {
        
        _waterLayout = [[WaterfallFlowLayout alloc] init];
        
        [_waterLayout setCellHeightWithBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
            return 120;
        }];
        //内间距
        _waterLayout.sectionInset = UIEdgeInsetsMake(20, 10, 10, 10);
    }
    return _waterLayout;
}

@end
