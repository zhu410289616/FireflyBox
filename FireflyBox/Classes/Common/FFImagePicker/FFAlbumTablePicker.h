//
//  FFAlbumTablePicker.h
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFTableViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "FFAssetSelectionDelegate.h"

@interface FFAlbumTablePicker : FFTableViewController<FFAssetSelectionDelegate>

@property (nonatomic, weak) id<FFAssetSelectionDelegate> delegate;
@property (nonatomic, assign) BOOL isUpdated;

- (void)cancelImagePicker;
- (void)doneImagePicker:(NSArray *)assets;

@end
