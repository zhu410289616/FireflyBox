//
//  FFMultiPhotoBrower.h
//  FireflyBox
//
//  Created by pig on 14-6-10.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseViewController.h"
#import "FFPhotosDataSource.h"
#import "FFPhotoViewDelegate.h"
#import "FFPhotoThumbnailBar.h"
#import "FFAssetSelectionDelegate.h"

@interface FFMultiPhotoBrower : FFBaseViewController<UICollectionViewDelegate, UICollectionViewDataSource, FFAssetSelectionDelegate, FFPhotoViewDelegate>

@property (nonatomic, strong) FFPhotoThumbnailBar *thumbnailBar;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) FFPhotosDataSource *photosDataSource;

@end
