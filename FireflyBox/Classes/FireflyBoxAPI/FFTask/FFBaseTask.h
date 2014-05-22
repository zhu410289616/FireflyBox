//
//  FFBaseTask.h
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFBaseTask;

typedef void(^TaskFinishBlock)(id task);

/**
 * 需要修改成继承自operation, 使用queue去执行main函数
 */
@interface FFBaseTask : NSObject

@property (nonatomic, strong) NSString *taskId;
@property (nonatomic, copy) TaskFinishBlock finishBlock;

/**
 *  please don't override
 */
- (void)execute;

/**
 *  override this function
 */
- (void)executeTask;

@end