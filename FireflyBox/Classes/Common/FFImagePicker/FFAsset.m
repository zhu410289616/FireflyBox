//
//  FFAsset.m
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFAsset.h"

@implementation FFAsset

- (id)initWithAsset:(ALAsset *)tAsset
{
    if (self = [super init]) {
        self.asset = tAsset;
        self.selected = NO;
    }
    return self;
}

- (void)setAssetSelected:(BOOL)isSelected
{
    if (isSelected) {
        if ([self.delegate respondsToSelector:@selector(shouldSelectAsset:)]) {
            if (![self.delegate shouldSelectAsset:self]) {
                return;
            }
        }
    }
    self.selected = isSelected;
    if (isSelected) {
        if ([self.delegate respondsToSelector:@selector(assetSelected:)]) {
            [self.delegate assetSelected:self];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(assetCanceled:)]) {
            [self.delegate assetCanceled:self];
        }
    }
}

@end
