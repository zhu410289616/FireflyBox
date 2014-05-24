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

- (id)init
{
    if (self = [super init]) {
        [self initTask];
    }
    return self;
}

/**
 *  初始化任务配置
 */
- (void)initTask
{
    self.taskId = [NSString stingWithSequence];
    self.taskQueueType = [self getFFTaskQueueType];
}

/**
 *  子类可以通过重栽该方法修改任务执行queue的类型
 *
 *  @return FFTaskQueueType
 */
- (FFTaskQueueType)getFFTaskQueueType
{
    return FFTaskQueueTypeDefault;
}

/**
 *  通过start方法，把认为加入queue执行
 */
- (void)start
{
    switch ([self getFFTaskQueueType]) {
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
        
        [self executeTask];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.finishBlock) {
                self.finishBlock(self);
            }
        });
        
    }
    @catch (NSException *exception) {
        if (self.errorBlock) {
            NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"name: %@, reason: %@", exception.name, exception.reason] code:0 userInfo:exception.userInfo];
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
