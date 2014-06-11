//
//  FFPhotoThumbnailView.h
//  FireflyBox
//
//  Created by pig on 14-6-10.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFAsset.h"
#import "FFPhotoViewDelegate.h"

@interface FFPhotoThumbnailView : UIView

@property (nonatomic, strong) UIImageView *thumbnailImageView;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) FFAsset *ffAsset;
@property (nonatomic, weak) id<FFPhotoViewDelegate> delegate;

- (id)initWithFFAsset:(FFAsset *)ffAsset frame:(CGRect)frame;
- (void)startShake;
- (void)stopShake;

@end
