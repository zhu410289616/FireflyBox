//
//  FFBaseRunnable.m
//  FireflyBox
//
//  Created by pig on 14-5-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseRunnable.h"

@implementation FFBaseRunnable

- (void)taskWillExecute
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ffBaseRunnableWillExecute:)]) {
        [self.delegate ffBaseRunnableWillExecute:self];
    }
}

- (void)taskExecuteFailed
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ffBaseRunnable:didExecuteFailed:)]) {
        [self.delegate ffBaseRunnable:self didExecuteFailed:nil];
    }
}

- (void)taskExecuteFinished
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ffBaseRunnable:didExecuteSuccess:)]) {
        [self.delegate ffBaseRunnable:self didExecuteSuccess:nil];
    }
}

- (void)ajaxIn
{
}

- (void)ajaxOut
{
}

- (void)ajaxFail
{
}

@end
