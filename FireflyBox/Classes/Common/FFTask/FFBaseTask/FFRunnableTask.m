//
//  FFRunnableTask.m
//  FireflyBox
//
//  Created by pig on 14-5-25.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFRunnableTask.h"

@implementation FFRunnableTask

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

/**
 *  通过execute方法统一处理任务事件, [重栽需注意]
 */
- (void)execute
{
    @try {
        
        [self.runnable ajaxIn];
        [self executeTask];
        [self.runnable ajaxOut];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.finishBlock) {
                self.finishBlock(self);
            }
        });
        
    }
    @catch (NSException *exception) {
        [self.runnable ajaxFail];
        if (self.errorBlock) {
            NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"name: %@, reason: %@", exception.name, exception.reason] code:0 userInfo:exception.userInfo];
            self.errorBlock(self, error);
        }
    }
}

@end
