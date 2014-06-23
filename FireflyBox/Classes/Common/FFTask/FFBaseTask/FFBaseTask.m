//
//  FFBaseTask.m
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseTask.h"
#import "FFConcurrentQueue.h"
#import "FFSerialQueue.h"

@implementation FFBaseTask

/**
 *  通过FFBaseRunnable初始化对象
 *
 *  @param FFBaseRunnable, 一个带有参数和回调方法的运行时对象
 *
 *  @return return FFBaseTask
 */
- (id)initWithRunnable:(FFBaseRunnable *)runnable
{
    if (self = [super init]) {
        self.runnable = runnable;
    }
    return self;
}

#pragma mark override function

- (NSString *)classId
{
    return [NSString stingWithSequence];
}

- (NSString *)className
{
    return @"com.firefly.FFBaseTask";
}

#pragma mark implement function

/**
 *  子类可以通过重栽该方法修改任务执行queue的类型
 *
 *  @return FFTaskQueueType
 */
- (FFTaskQueueType)taskQueueType
{
    return FFTaskQueueTypeDefault;
}

/**
 *  通过start方法，把认为加入queue执行
 */
- (void)start
{
    switch ([self taskQueueType]) {
        case FFTaskQueueTypeConcurrent:
            [[FFConcurrentQueue sharedInstance] addTask:self];
            break;
        case FFTaskQueueTypeSerial:
            [[FFSerialQueue sharedInstance] addTask:self];
            break;
            
        default:
        {
            FFBaseQueue *baseQueue = [[FFBaseQueue alloc] init];
            [baseQueue addTask:self];
        }
            break;
    }
}

/**
 *  通过execute方法统一处理任务事件, [禁止重栽]
 */
- (void)execute
{
    @try {
        
        [self.runnable ajaxIn:self];
        [self executeTask];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.runnable ajaxOut:self];
            if (self.finishBlock) {
                self.finishBlock(self);
            }
        });
        
    }
    @catch (NSException *exception) {
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"name: %@, reason: %@", exception.name, exception.reason] code:0 userInfo:exception.userInfo];
        [self.runnable ajaxFail:self error:error];
        if (self.errorBlock) {
            self.errorBlock(self, error);
        }
    }
}

/**
 *  通过重栽该方法处理任务逻辑
 */
- (void)executeTask
{
    //todo
}

@end
