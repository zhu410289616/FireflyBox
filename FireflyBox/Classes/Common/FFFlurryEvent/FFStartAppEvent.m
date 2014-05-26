//
//  FFStartAppEvent.m
//  FireflyBox
//
//  Created by pig on 14-5-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFStartAppEvent.h"
#import "Flurry.h"
#import "FFCommonUtil.h"
#import "FFFlurryEventConfig.h"

void uncaughtExceptionHandler(NSException *exception)
{
    [Flurry logError:@"Uncaught" message:@"Crash!" exception:exception];
}

@implementation FFStartAppEvent

- (void)eventWillExecute
{
    [super eventWillExecute];
    [Flurry startSession:FLURRY_APP_KEY];
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    NSString *appVersion = [FFCommonUtil getBundleVersion];
    [Flurry setAppVersion:appVersion];
    [Flurry setCrashReportingEnabled:YES];
    [Flurry setSessionReportsOnPauseEnabled:YES];
    [Flurry setBackgroundSessionEnabled:NO];
}

#pragma mark FFBaseFlurryEventDelegate method

- (NSString *)flurryEventName
{
    return FLURRY_EVENT_NAME_START_APP;
}

@end
