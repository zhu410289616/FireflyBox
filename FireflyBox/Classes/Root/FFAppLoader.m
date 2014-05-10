//
//  FFAppLoader.m
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFAppLoader.h"
#import <AVFoundation/AVFoundation.h>
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
        [self setAudioSession];
        
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
    [GLOBAL_APP setStatusBarStyle:UIStatusBarStyleDefault];
    [GLOBAL_APP setStatusBarHidden:NO];
    
}

//这种方式后台，可以连续播放非网络请求歌曲。遇到网络请求歌曲就废，需要后台申请task
- (void)setAudioSession
{
    /*
     * AudioSessionInitialize用于处理中断处理，
     * AVAudioSession主要调用setCategory和setActive方法来进行设置，
     * AVAudioSessionCategoryPlayback一般用于支持后台播放
     */
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *setCategoryError = nil;
    [session setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    NSError *activationError = nil;
    [session setActive:YES error:&activationError];
}

- (void)testFunction
{
    [UIFont showAllFont];
}

@end
