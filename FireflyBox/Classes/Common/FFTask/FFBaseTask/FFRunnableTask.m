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

- (void)executeTask
{
    [self.runnable ajaxIn];
    [self.runnable ajaxOut];
}

@end
