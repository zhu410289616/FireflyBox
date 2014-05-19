//
//  NSInvocation+FireFly.h
//  FireflyBox
//
//  Created by pig on 14-5-19.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSInvocation (FireFly)

+ (NSInvocation*)invocationWithTarget:(id)target andSelector:(SEL)selector;
+ (NSInvocation*)invocationWithTarget:(id)target selector:(SEL)selector andArguments:(NSArray*)arguments;

@end
