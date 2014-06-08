//
//  FFAssetPickerBar.h
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFAsset.h"
#import "FFAssetPickerItem.h"

@interface FFAssetPickerBar : UIScrollView<FFAssetDelegate>

@property (nonatomic, strong) NSMutableArray *selectedAssets;
@property (nonatomic, weak) id<FFAssetDelegate> ffAssetDelegate;

- (void)addAsset:(FFAsset *)ffAsset;
- (void)removeAsset:(FFAsset *)ffAsset;

- (void)reloadData;

@end
