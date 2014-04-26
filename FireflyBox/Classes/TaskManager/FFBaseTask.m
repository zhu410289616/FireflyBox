//
//  FFBaseTask.m
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseTask.h"

@implementation FFBaseTask

- (void)execute
{
    [self executeTask];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_finishBlock) {
            _finishBlock(self);
        }
    });
}

/*
 * implement by sub class
 */
- (void)executeTask
{
    //todo
}

@end
