//
//  FFConcurrentQueue.m
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFConcurrentQueue.h"

static const char *concurrentQueueLabel = "com.firefly.concurrentqueue";

@implementation FFConcurrentQueue

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
    return dispatch_queue_create(concurrentQueueLabel, DISPATCH_QUEUE_CONCURRENT);
}

@end
