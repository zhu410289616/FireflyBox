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

- (void)addTask:(FFBaseTask *)tTask queue:(dispatch_queue_t)tQueue;
- (void)addTask:(FFBaseTask *)tTask;

@end
