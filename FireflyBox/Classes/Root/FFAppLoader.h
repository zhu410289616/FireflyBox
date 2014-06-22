//
//  FFAppLoader.h
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFAppLoader : NSObject

@property (assign) BOOL isLoaded;

+ (id)sharedInstance;

- (void)initLoader;

- (void)initAppLevelUIConfig;

/**
 *  制定定时提醒计划
 */
- (void)doLocalNotificationSchema;

- (void)testFunction;

@end
