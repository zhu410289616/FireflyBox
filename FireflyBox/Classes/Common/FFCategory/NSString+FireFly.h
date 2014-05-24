//
//  NSString+FireFly.h
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FireFly)

/**
 *  生成唯一字符串
 *
 *  @return sequence
 */
+ (NSString *)stingWithSequence;

+ (NSString *)stringByMd5Encode:(NSString *)tString;

//格式化时间为字符串
+ (NSString *)stringWithDate:(NSDate *)tDate formatter:(NSString *)tFormatter;
+ (NSString *)stringWithTime:(long)tTimeInterval formatter:(NSString *)tFormatter;

@end
