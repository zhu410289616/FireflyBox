//
//  FFRunnableTask.h
//  FireflyBox
//
//  Created by pig on 14-5-25.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseTask.h"
#import "FFBaseRunnable.h"

@interface FFRunnableTask : FFBaseTask

@property (nonatomic, strong) FFBaseRunnable *runnable;

/**
 *  通过FFBaseRunnable初始化对象
 *
 *  @param FFBaseRunnable, 一个带有参数和回调方法的运行时对象
 *
 *  @return return FFBaseTask
 */
- (id)initWithRunnable:(FFBaseRunnable *)runnable;

@end
