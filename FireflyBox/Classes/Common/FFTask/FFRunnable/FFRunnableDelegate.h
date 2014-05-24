//
//  FFRunnableDelegate.h
//  FireflyBox
//
//  Created by pig on 14-5-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFBaseRunnable;

@protocol FFRunnableDelegate <NSObject>

- (void)ffBaseRunnableWillExecute:(FFBaseRunnable *)baseRunnable;
- (void)ffBaseRunnable:(FFBaseRunnable *)baseRunnable didExecuteFailed:(NSError *)error;
- (void)ffBaseRunnable:(FFBaseRunnable *)baseRunnable didExecuteSuccess:(id)result;

@end
