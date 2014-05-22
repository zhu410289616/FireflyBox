//
//  FFBaseQueue.m
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseQueue.h"

@implementation FFBaseQueue

- (void)addTask:(FFBaseTask *)tTask queue:(dispatch_queue_t)tQueue
{
    dispatch_block_t taskBlock = ^{
        [tTask execute];
    };
    dispatch_async(tQueue, taskBlock);
}

/*
 * implement in sub class
 */
- (void)addTask:(FFBaseTask *)tTask
{
    //todo
}

@end
