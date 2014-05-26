//
//  FFBaseFlurryEvent.h
//  FireflyBox
//
//  Created by pig on 14-5-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FFBaseFlurryEventDelegate <NSObject>

@required

/**
 *  通过实现该协议，确定flurry event的名称
 *
 *  @return event name
 */
- (NSString *)flurryEventName;

/**
 *  通过实现该协议，确定flurry event的参数
 *
 *  @return NSDictionary parameters
 */
- (NSDictionary *)flurryEventParameters;

@end

@interface FFBaseFlurryEvent : NSObject<FFBaseFlurryEventDelegate>

/**
 *  执行event前执行
 */
- (void)eventWillExecute;

/**
 *  执行flurry event纪录
 */
- (void)eventDidExecute;

/**
 *  统一调用方法
 */
- (void)execute;

@end
