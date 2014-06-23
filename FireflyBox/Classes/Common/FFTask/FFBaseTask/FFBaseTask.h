//
//  FFBaseTask.h
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseObject.h"
#import "FFBaseRunnable.h"

typedef enum {
    FFTaskQueueTypeDefault,
    FFTaskQueueTypeConcurrent,
    FFTaskQueueTypeSerial
} FFTaskQueueType;

typedef void(^FinishBlock)(id task);
typedef void(^ErrorBlock)(id task, NSError *error);

/**
 * 任务基础类，子类需要重栽executeTask方法
 * 通过runnable参数处理回调
 */
@interface FFBaseTask : FFBaseObject

@property (nonatomic, copy) FinishBlock finishBlock;
@property (nonatomic, copy) ErrorBlock errorBlock;

@property (nonatomic, strong) FFBaseRunnable *runnable;

/**
 *  通过FFBaseRunnable初始化对象
 *
 *  @param FFBaseRunnable, 一个带有参数和回调方法的运行时对象
 *
 *  @return return FFBaseTask
 */
- (id)initWithRunnable:(FFBaseRunnable *)runnable;

/**
 *  子类可以通过重栽该方法修改任务执行queue的类型
 *
 *  @return FFTaskQueueType
 */
- (FFTaskQueueType)taskQueueType;

/**
 *  通过start方法，把认为加入queue执行
 */
- (void)start;

/**
 *  通过execute方法统一处理任务事件, [禁止重栽]
 */
- (void)execute;

/**
 *  通过重栽该方法处理任务逻辑
 */
- (void)executeTask;

@end
