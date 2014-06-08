//
//  FFAssetPickerManager.m
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFAssetPickerManager.h"

@interface FFAssetPickerManager ()

/**
 *  ALAsset数组
 */
@property (strong) NSMutableArray *assetList;

@end

@implementation FFAssetPickerManager

+ (id)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    if (self = [super init]) {
        self.assetList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (ALAsset *)isExists:(ALAsset *)tAsset
{
    if (IS_IOS6_OR_HIGHER) {
        NSURL *ffAssetPropertyURL = [tAsset valueForProperty:ALAssetPropertyAssetURL];
        NSString *srcFFAssetPropertyURL = ffAssetPropertyURL.absoluteString;
        PLog(@"srcFFAssetPropertyURL: %@", srcFFAssetPropertyURL);
        
        for (ALAsset *asset in self.assetList) {
            NSURL *assetPropertyURL = [asset valueForProperty:ALAssetPropertyAssetURL];
            NSString *strAssetPropertyURL = assetPropertyURL.absoluteString;
            PLog(@"strAssetPropertyURL: %@", strAssetPropertyURL);
            if ([srcFFAssetPropertyURL compare:strAssetPropertyURL] == NSOrderedSame) {
                return asset;
            }
        }
    } else {
        NSURL *ffAssetPropertyURL = [[tAsset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[tAsset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]];
        NSString *srcFFAssetPropertyURL = ffAssetPropertyURL.absoluteString;
        PLog(@"srcFFAssetPropertyURL: %@", srcFFAssetPropertyURL);
        
        for (ALAsset *asset in self.assetList) {
            NSURL *assetPropertyURL = [[asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]];
            NSString *strAssetPropertyURL = assetPropertyURL.absoluteString;
            PLog(@"strAssetPropertyURL: %@", strAssetPropertyURL);
            if ([srcFFAssetPropertyURL compare:strAssetPropertyURL] == NSOrderedSame) {
                return asset;
            }
        }
    }
    return nil;
}

- (void)addAsset:(ALAsset *)tAsset
{
    [self.assetList addObject:tAsset];
}

- (void)removeAsset:(ALAsset *)tAsset
{
    ALAsset *asset = [self isExists:tAsset];
    [self.assetList removeObject:asset];
}

- (void)removeAllAssets
{
    [self.assetList removeAllObjects];
}

- (NSArray *)getAssets
{
    return self.assetList;
}

@end
