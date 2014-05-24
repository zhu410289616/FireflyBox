//
//  FFSerialQueue.m
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFSerialQueue.h"

static const char *serialQueueLabel = "com.firefly.serialqueue";

@implementation FFSerialQueue

+ (id)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark implement method

- (dispatch_queue_t)getTaskQueue
{
    return dispatch_queue_create(serialQueueLabel, DISPATCH_QUEUE_SERIAL);
}

@end
