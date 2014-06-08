//
//  FFAssetPickerManager.h
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFAsset.h"

@interface FFAssetPickerManager : NSObject

+ (id)sharedInstance;
- (FFAsset *)isExists:(FFAsset *)ffAsset;
- (BOOL)isLastAsset:(FFAsset *)ffAsset;
- (void)addAsset:(FFAsset *)ffAsset;
- (void)removeAsset:(FFAsset *)ffAsset;
- (void)removeAllAssets;
- (NSArray *)getAssets;


@end
