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


static NSString * const kIdentifierCell = @"BQCollectionViewCell";

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) WaterfallFlowLayout *waterLayout;
@property (nonatomic, copy) NSArray *imageArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self downloadData];
}

- (void)downloadData {
    self.imageArr = @[@"0.jpg",@"1.png",@"2.png",@"3.png",@"4.png",@"5.png",
                      @"6.png",@"7.jpg",@"8.jpg",@"9.jpg",@"10.jpg",@"11.jpg",
                      @"12.jpg",@"13.jpg",@"14.jpg",@"16.jpg",@"17.jpg",@"18.jpg",
                      @"19.jpg",@"20.jpg",@"21.png"];
    
    // 设置高度
    typeof(self) blockSelf = self;
    [_waterLayout setCellHeightWithBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
        
        UIImage *image = [UIImage imageNamed:blockSelf.imageArr[indexPath.row]];
        return (image.size.height * (self.view.bounds.size.width- 10 * 4)/3) / image.size.width;
        
    }];
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
    cell.imgView.image = [UIImage imageNamed:_imageArr[indexPath.row]];
    cell.userInteractionEnabled = YES;
    return cell;
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
        
        //内间距
        _waterLayout.sectionInset = UIEdgeInsetsMake(20, 10, 10, 10);
    }
    return _waterLayout;
}

@end
