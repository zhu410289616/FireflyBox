//
//  FFSharedMacro.h
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#ifndef FireflyBox_FFSharedMacro_h
#define FireflyBox_FFSharedMacro_h

#ifdef DEBUG
#define PLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define PLog(format, ...)
#endif

#define FRAMELOG(a) PLog(@"frame log: %f %f %f %f", a.frame.origin.x, a.frame.origin.y, a.frame.size.width, a.frame.size.height)

//
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_IOS7_OR_HIGHER       SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#define IS_RETINA_SCREEN        [[UIDevice currentDevice] isRetinaScreen]

//
#define GLOBAL_SCREEN_SIZE      ([UIScreen mainScreen].bounds.size)
#define GLOBAL_SCREEN_WIDTH     (GLOBAL_SCREEN_SIZE.width)
#define GLOBAL_SCREEN_HEIGHT    (GLOBAL_SCREEN_SIZE.height)

#define GLOBAL_TABBAR_HEIGHT    50.0f

#define GLOBAL_APP_DELEGATE     ((AppDelegate *)([UIApplication sharedApplication].delegate))

#endif
