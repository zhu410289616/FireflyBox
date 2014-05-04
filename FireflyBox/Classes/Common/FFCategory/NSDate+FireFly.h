//
//  NSDate+FireFly.h
//  FireflyBox
//
//  Created by pig on 14-5-4.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FireFly)

+ (NSDate *)dateWithString:(NSString *)tDateStr formatter:(NSString *)tFormatter;
+ (NSTimeInterval)timeIntervalWithString:(NSString *)tDateStr formatter:(NSString *)tFormatter;

@end
