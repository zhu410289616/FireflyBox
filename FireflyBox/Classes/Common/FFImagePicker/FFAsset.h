//
//  FFAsset.h
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class FFAsset;

@protocol FFAssetDelegate <NSObject>

@optional

- (void)assetSelected:(FFAsset *)ffAsset;
- (BOOL)shouldSelectAsset:(FFAsset *)ffAsset;
- (void)assetCanceled:(FFAsset *)ffAsset;

@end

@interface FFAsset : NSObject

@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, weak) id<FFAssetDelegate> delegate;

- (id)initWithAsset:(ALAsset *)tAsset;
- (void)setAssetSelected:(BOOL)isSelected;

@end
