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

- (FFAsset *)isExists:(FFAsset *)ffAsset
{
    if (IS_IOS6_OR_HIGHER) {
        NSURL *ffAssetPropertyURL = [ffAsset.asset valueForProperty:ALAssetPropertyAssetURL];
        NSString *srcFFAssetPropertyURL = ffAssetPropertyURL.absoluteString;
        FFLog(@"srcFFAssetPropertyURL: %@", srcFFAssetPropertyURL);
        
        for (FFAsset *tempFFAsset in self.assetList) {
            NSURL *assetPropertyURL = [tempFFAsset.asset valueForProperty:ALAssetPropertyAssetURL];
            NSString *strAssetPropertyURL = assetPropertyURL.absoluteString;
            FFLog(@"strAssetPropertyURL: %@", strAssetPropertyURL);
            if ([srcFFAssetPropertyURL compare:strAssetPropertyURL] == NSOrderedSame) {
                return tempFFAsset;
            }
        }
    } else {
        NSURL *ffAssetPropertyURL = [[ffAsset.asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[ffAsset.asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]];
        NSString *srcFFAssetPropertyURL = ffAssetPropertyURL.absoluteString;
        FFLog(@"srcFFAssetPropertyURL: %@", srcFFAssetPropertyURL);
        
        for (FFAsset *tempFFAsset in self.assetList) {
            NSURL *assetPropertyURL = [[tempFFAsset.asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[tempFFAsset.asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]];
            NSString *strAssetPropertyURL = assetPropertyURL.absoluteString;
            FFLog(@"strAssetPropertyURL: %@", strAssetPropertyURL);
            if ([srcFFAssetPropertyURL compare:strAssetPropertyURL] == NSOrderedSame) {
                return tempFFAsset;
            }
        }
    }
    return nil;
}

- (BOOL)isLastAsset:(FFAsset *)ffAsset
{
    if (IS_IOS6_OR_HIGHER) {
        NSURL *ffAssetPropertyURL = [ffAsset.asset valueForProperty:ALAssetPropertyAssetURL];
        NSString *srcFFAssetPropertyURL = ffAssetPropertyURL.absoluteString;
        
        FFAsset *lastAsset = [self.assetList lastObject];
        NSURL *assetPropertyURL = [lastAsset.asset valueForProperty:ALAssetPropertyAssetURL];
        NSString *strAssetPropertyURL = assetPropertyURL.absoluteString;
        if ([srcFFAssetPropertyURL compare:strAssetPropertyURL] == NSOrderedSame) {
            return YES;
        }
    } else {
        NSURL *ffAssetPropertyURL = [[ffAsset.asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[ffAsset.asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]];
        NSString *srcFFAssetPropertyURL = ffAssetPropertyURL.absoluteString;
        
        FFAsset *lastAsset = [self.assetList lastObject];
        NSURL *assetPropertyURL = [[lastAsset.asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[lastAsset.asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]];
        NSString *strAssetPropertyURL = assetPropertyURL.absoluteString;
        if ([srcFFAssetPropertyURL compare:strAssetPropertyURL] == NSOrderedSame) {
            return YES;
        }
    }
    
    return NO;
}

- (void)addAsset:(FFAsset *)ffAsset
{
    [self.assetList addObject:ffAsset];
}

- (void)removeAsset:(FFAsset *)ffAsset
{
    FFAsset *tempFFAsset = [self isExists:ffAsset];
    if (tempFFAsset) {
        [self.assetList removeObject:tempFFAsset];
    }
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
