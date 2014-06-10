//
//  NSData+FireFly.h
//  FireflyBox
//
//  Created by pig on 14-6-7.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (FireFly)

/**
 *  string编码转data
 *
 *  @param tString  tString description
 *  @param encoding encoding description
 *
 *  @return nsstring
 */
+ (NSData *)dataWithString:(NSString *)tString encoding:(NSStringEncoding)encoding;

/**
 *  string编码转data
 *  default NSUTF8StringEncoding
 *
 *  @param tString tString description
 *
 *  @return nsdata
 */
+ (NSData *)dataWithString:(NSString *)tString;

@end