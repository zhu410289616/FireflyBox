//
//  FFSimplePhotoBrower.h
//  FireflyBox
//
//  Created by pig on 14-6-10.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseViewController.h"
#import "FFPhotosDataSource.h"
#import "FFPhotoViewDelegate.h"

@interface FFSimplePhotoBrower : FFBaseViewController<UICollectionViewDelegate, UICollectionViewDataSource, FFPhotoViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) FFPhotosDataSource *photosDataSource;

@end
