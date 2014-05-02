//
//  FFAppLoader.m
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFAppLoader.h"
#import "FFDB+All.h"

@implementation FFAppLoader

+ (id)sharedInstance
{
    static id appLoaderInstance = nil;
    static dispatch_once_t appLoaderOnceToken;
    dispatch_once(&appLoaderOnceToken, ^{
        appLoaderInstance = [[self alloc] init];
    });
    return appLoaderInstance;
}

- (void)initLoader
{
    @synchronized(self)
    {
        if (_isLoaded) {
            return;
        }
        [self initAppLevelUIConfig];
        [[FFDB sharedInstance] initAll];
        _isLoaded = YES;
    }
    
}

- (void)initAppLevelUIConfig
{
    UIImage *backButtonBg = [[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(2, 2)] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    
    if (IS_IOS7_OR_HIGHER) {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHex:0xf8f8f8]];
    } else {
        [[UINavigationBar appearance] setBackgroundImage:backButtonBg forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithHex:0xf8f8f8]];
    }
    
    //config for StatusBar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
}

- (void)testFunction
{
    [UIFont showAllFont];
}

@end
