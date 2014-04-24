//
//  FFAppLoader.h
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFAppLoader : NSObject

@property (nonatomic, assign) BOOL isLoaded;

+ (id)sharedInstance;

- (void)initLoader;
- (void)initAppLevelUIConfig;

@end
