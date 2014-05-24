//
//  FFBaseTask.h
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FFTaskQueueTypeDefault,
    FFTaskQueueTypeConcurrent,
    FFTaskQueueTypeSerial
} FFTaskQueueType;

typedef void(^TaskErrorBlock)(id task, NSError *error);
typedef void(^TaskFinishBlock)(id task);

/**
 * 任务基础类，子类需要重栽executeTask方法
 * 通过runnable参数处理回调
 */
@interface FFBaseTask : NSObject

@property (nonatomic, strong) NSString *taskId;
@property (nonatomic, assign) FFTaskQueueType taskQueueType;
@property (nonatomic, copy) TaskErrorBlock errorBlock;
@property (nonatomic, copy) TaskFinishBlock finishBlock;

/**
 *  初始化任务配置
 */
- (void)initTask;

/**
 *  子类可以通过重栽该方法修改任务执行queue的类型
 *
 *  @return FFTaskQueueType
 */
- (FFTaskQueueType)getFFTaskQueueType;

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
