//
//  NSDate+FireFly.m
//  FireflyBox
//
//  Created by pig on 14-5-4.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "NSDate+FireFly.h"

@implementation NSDate (FireFly)

+ (NSDate *)dateWithString:(NSString *)tDateStr formatter:(NSString *)tFormatter
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if (tFormatter) {
        [dateformatter setDateFormat:tFormatter];
    }
    NSDate *date = [dateformatter dateFromString:tDateStr];
    return date;
}

+ (NSTimeInterval)timeIntervalWithString:(NSString *)tDateStr formatter:(NSString *)tFormatter
{
    return [[NSDate dateWithString:tDateStr formatter:tFormatter] timeIntervalSince1970];
}

@end
