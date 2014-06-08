//
//  FFAssetSelectionDelegate.h
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFAsset;

@protocol FFAssetSelectionDelegate <NSObject>

@required

- (void)selectedAssets:(NSArray *)ffAssets isUpdated:(BOOL)isUpdated;
- (BOOL)hadSelectedAsset:(FFAsset *)ffAsset;
- (void)updateAssetStatus:(FFAsset *)ffAsset isSelected:(BOOL)isSelected;

@optional

- (BOOL)shouldSelectAsset:(FFAsset *)ffAsset previousCount:(NSUInteger)previousCount;
- (int)shouldSelectAssetCount;
- (BOOL)isFirstSelectedAsset:(FFAsset *)ffAsset;
- (BOOL)isLastestSelectedAsset:(FFAsset *)ffAsset;

@end
