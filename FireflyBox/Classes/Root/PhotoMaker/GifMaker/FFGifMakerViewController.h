//
//  FFGifMakerViewController.h
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseViewController.h"
#import "FFAssetSelectionDelegate.h"
#import "FFPhotoThumbnailBar.h"

@interface FFGifMakerViewController : FFBaseViewController<FFAssetSelectionDelegate, FFPhotoViewDelegate>

@property (nonatomic, strong) FFPhotoThumbnailBar *assetPickerBar;

@end
