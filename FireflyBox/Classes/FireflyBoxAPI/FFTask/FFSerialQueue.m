//
//  FFSerialQueue.m
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFSerialQueue.h"

static const char *serialQueueLabel = "com.firefly.box.serialqueue";

@implementation FFSerialQueue

+ (id)sharedSerialQueue
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
        _serialQueue = dispatch_queue_create(serialQueueLabel, DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

#pragma mark implement method

- (void)addTask:(FFBaseTask *)tTask
{
    [self addTask:tTask queue:_serialQueue];
}

@end
