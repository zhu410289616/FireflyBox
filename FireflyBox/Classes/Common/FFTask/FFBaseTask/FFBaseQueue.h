//
//  FFBaseQueue.h
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFBaseTask.h"

@interface FFBaseQueue : NSObject

/**
 *  重栽该方法，可以指定执行任务的queue
 *
 *  @return dispatch_queue_t
 */
- (dispatch_queue_t)getTaskQueue;

/**
 *  将task加入queue中，开始执行任务
 *
 *  @param tTask  FFBaseTask
 *  @param tQueue dispatch_queue_t
 */
- (void)addTask:(FFBaseTask *)tTask queue:(dispatch_queue_t)tQueue;

/**
 *  加入任务到queue中执行
 *
 *  @param tTask FFBaseTask
 */
- (void)addTask:(FFBaseTask *)tTask;

@end
