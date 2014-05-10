//
//  FFAppLoader.m
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFAppLoader.h"
#import "MobClick.h"
#import <AVFoundation/AVFoundation.h>
#import "FFDB+All.h"


#define UMENG_APPKEY @"5367ab6d56240b4bf2087862"

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
        [self umengTrack];//
        [self initAppLevelUIConfig];
        [self setAudioSession];
        
        [[FFDB sharedInstance] initAll];
        _isLoaded = YES;
    }
    
}

#pragma mark umeng function

- (void)umengTrack {
    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
    //    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
    [MobClick updateOnlineConfig];  //在线参数配置
    
    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}

#pragma mark ui config

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

#pragma mark audio session for play music

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
