//
//  FFBaseFlurryEvent.m
//  FireflyBox
//
//  Created by pig on 14-5-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseFlurryEvent.h"
#import "Flurry.h"

@implementation FFBaseFlurryEvent

/**
 *  执行event前执行
 *
 *  do nothing in FFBaseFlurryEvent class
 */
- (void)eventWillExecute
{
    //do nothing in base class
}

/**
 *  执行flurry event纪录
 */
- (void)eventDidExecute
{
    NSString *event = [self flurryEventName];
    NSDictionary *parameters = [self flurryEventParameters];
    [Flurry logEvent:event withParameters:parameters];
}

/**
 *  统一调用方法
 */
- (void)execute
{
    [self eventWillExecute];
    [self eventDidExecute];
}

#pragma mark FFBaseFlurryEventDelegate method

/**
 *  通过实现该协议，确定flurry event的名称
 *
 *  @return event name
 */
- (NSString *)flurryEventName
{
    return @"BaseFlurryEvent";
}

/**
 *  通过实现该协议，确定flurry event的参数
 *
 *  @return NSDictionary parameters
 */
- (NSDictionary *)flurryEventParameters
{
    NSMutableDictionary *dicParameters = [[NSMutableDictionary alloc] init];
    return dicParameters;
}

@end
