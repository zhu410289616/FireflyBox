//
//  FFGifMakerViewController.h
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseViewController.h"
#import "FFAssetSelectionDelegate.h"
#import "FFAssetPickerBar.h"

@interface FFGifMakerViewController : FFBaseViewController<FFAssetSelectionDelegate, FFAssetDelegate>

@property (nonatomic, strong) FFAssetPickerBar *assetPickerBar;

@end
