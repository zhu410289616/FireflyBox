//
//  FFBaseQueue.m
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseQueue.h"

static const char *baseQueueLabel = "com.firefly.basequeue";

@implementation FFBaseQueue

/**
 *  返回默认优先级的queue
 *
 *  重栽该方法可以指定执行任务的queue
 *
 *  @return dispatch_queue_create(baseQueueLabel, DISPATCH_QUEUE_PRIORITY_DEFAULT)
 */
- (dispatch_queue_t)getTaskQueue
{
    return dispatch_queue_create(baseQueueLabel, DISPATCH_QUEUE_PRIORITY_DEFAULT);
}

/**
 *  将task加入queue中，开始执行任务
 *
 *  @param tTask  FFBaseTask
 *  @param tQueue dispatch_queue_t
 */
- (void)addTask:(FFBaseTask *)tTask queue:(dispatch_queue_t)tQueue
{
    dispatch_block_t taskBlock = ^{
        [tTask execute];
    };
    dispatch_async(tQueue, taskBlock);
}

/**
 *  加入任务到queue中执行
 *
 *  @param tTask FFBaseTask
 */
- (void)addTask:(FFBaseTask *)tTask
{
    [self addTask:tTask queue:[self getTaskQueue]];
}

@end
