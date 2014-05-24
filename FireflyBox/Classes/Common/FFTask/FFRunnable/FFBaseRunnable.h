//
//  FFBaseRunnable.h
//  FireflyBox
//
//  Created by pig on 14-5-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseSerializable.h"
#import "FFRunnableDelegate.h"

@interface FFBaseRunnable : FFBaseSerializable<FFRunnableDelegate>

@property (nonatomic, weak) id<FFRunnableDelegate> delegate;

/**
 *  task流程逻辑
 */
- (void)taskWillExecute;
- (void)taskExecuteFailed;
- (void)taskExecuteFinished;

/**
 *  task具体参数逻辑
 */
- (void)ajaxIn;
- (void)ajaxOut;
- (void)ajaxFail;

@end
