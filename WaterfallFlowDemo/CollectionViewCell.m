//
//  CollectionViewCell.m
//  WaterfallFlowDemo
//
//  Created by Daniel on 16/3/9.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor orangeColor];
        
        // close autoresizing
        [_imgView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        // autolayout
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imgView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.f constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imgView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.f constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imgView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.f constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imgView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.f constant:0]];
        
        [self addSubview:_imgView];
    }
    return self;
}

@end
