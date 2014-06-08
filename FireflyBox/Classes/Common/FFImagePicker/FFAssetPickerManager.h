//
//  FFAssetPickerManager.h
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface FFAssetPickerManager : NSObject

+ (id)sharedInstance;
- (ALAsset *)isExists:(ALAsset *)tAsset;
- (void)addAsset:(ALAsset *)tAsset;
- (void)removeAsset:(ALAsset *)tAsset;
- (void)removeAllAssets;
- (NSArray *)getAssets;


@end
