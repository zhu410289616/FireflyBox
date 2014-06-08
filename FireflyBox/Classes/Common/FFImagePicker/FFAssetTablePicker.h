//
//  FFAssetTablePicker.h
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFTableViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "FFAsset.h"
#import "FFAssetSelectionDelegate.h"

@interface FFAssetTablePicker : FFTableViewController<FFAssetDelegate>

@property (nonatomic, weak) id<FFAssetSelectionDelegate> delegate;
@property (nonatomic, strong) ALAssetsGroup *assetGroup;
@property (nonatomic, strong) NSThread *preparePhotosThread;
@property (nonatomic, assign) BOOL isUpdated;

@end
