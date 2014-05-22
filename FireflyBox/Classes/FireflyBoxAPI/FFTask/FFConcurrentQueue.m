//
//  FFConcurrentQueue.m
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFConcurrentQueue.h"

static const char *concurrentQueueLabel = "com.firefly.box.concurrentqueue";

@implementation FFConcurrentQueue

+ (id)sharedConcurrentQueue
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
        _concurrentQueue = dispatch_queue_create(concurrentQueueLabel, DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

#pragma mark implement method

- (void)addTask:(FFBaseTask *)tTask
{
    [self addTask:tTask queue:_concurrentQueue];
}

@end
