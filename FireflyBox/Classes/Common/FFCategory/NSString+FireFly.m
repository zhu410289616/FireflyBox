//
//  NSString+FireFly.m
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "NSString+FireFly.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (FireFly)

/**
 *  生成唯一字符串
 *
 *  @return sequence
 */
+ (NSString *)stingWithSequence
{
    NSDate *time = [NSDate date];
    NSTimeInterval timeInterval = [time timeIntervalSince1970];
    return [NSString stringWithFormat:@"%f%d", timeInterval, arc4random()];//arc4random
}

+ (NSString *)stringByMd5Encode:(NSString *)tString
{
    @try {
        if(tString && [tString isKindOfClass:[NSString class]]){
            const char *cStr = [tString UTF8String];
            unsigned char result[16];
            CC_MD5(cStr, strlen(cStr), result);
            
            return [NSString stringWithFormat:
                    @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                    result[0], result[1], result[2], result[3],
                    result[4], result[5], result[6], result[7],
                    result[8], result[9], result[10], result[11],
                    result[12], result[13], result[14], result[15]
                    ];
        }
    }
    @catch (NSException *exception) {
        PLog(@"string md5 encode error... %@", tString);
    }
    return tString;
}

+ (NSString *)stringWithDate:(NSDate *)tDate formatter:(NSString *)tFormatter
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if (tFormatter) {
        [dateformatter setDateFormat:tFormatter];
    }
    NSString *strTime = [dateformatter stringFromDate:tDate];
    return strTime;
}

+ (NSString *)stringWithTime:(long)tTimeInterval formatter:(NSString *)tFormatter
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if (tFormatter) {
        [dateformatter setDateFormat:tFormatter];
    }
    NSDate *tempDate = [NSDate dateWithTimeIntervalSince1970:tTimeInterval];
    NSString *strTime = [dateformatter stringFromDate:tempDate];
    return strTime;
}

@end
