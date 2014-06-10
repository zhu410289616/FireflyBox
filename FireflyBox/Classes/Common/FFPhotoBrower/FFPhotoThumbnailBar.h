//
//  FFPhotoThumbnailBar.h
//  FireflyBox
//
//  Created by pig on 14-6-10.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFPhotoThumbnailView.h"

@interface FFPhotoThumbnailBar : UIScrollView<FFPhotoViewDelegate>

@property (nonatomic, strong) NSMutableArray *ffAssetList;
@property (nonatomic, weak) id<FFPhotoViewDelegate> photoThumbnailDelegate;

- (void)addFFAsset:(FFAsset *)ffAsset;
- (void)removeFFAsset:(FFAsset *)ffAsset;

- (void)reloadData;

@end
