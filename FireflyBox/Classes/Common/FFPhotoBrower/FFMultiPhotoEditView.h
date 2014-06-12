//
//  FFMultiPhotoEditView.h
//  FireflyBox
//
//  Created by pig on 14-6-12.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFAsset.h"
#import "FFPhotoViewDelegate.h"

@interface FFMultiPhotoEditView : UIView<FFPhotoViewDelegate>

@property (nonatomic, strong) NSMutableArray *visibleThumbnailViews;
@property (nonatomic, weak) id<FFPhotoViewDelegate> photoThumbnailDelegate;
@property (nonatomic, assign) BOOL isShaking;
@property (nonatomic, weak) FFPhotoThumbnailView *dragThumbnailView;
@property (nonatomic, assign) CGPoint previousPoint;

- (void)addFFAssetList:(NSArray *)ffAssetList;
- (void)addFFAsset:(FFAsset *)ffAsset;
- (void)removeAllFFAsset;
- (void)removeFFAsset:(FFAsset *)ffAsset;
- (void)reloadData;

- (void)doDrag:(CGPoint)currentPoint;

@end
