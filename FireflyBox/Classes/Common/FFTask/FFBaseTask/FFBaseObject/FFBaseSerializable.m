//
//  FFBaseSerializable.m
//  FireflyBox
//
//  Created by pig on 14-6-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseSerializable.h"

@implementation FFBaseSerializable

#pragma mark override function

- (NSString *)className
{
    return @"com.firefly.BaseSerializable";
}

#pragma mark implement function

- (NSArray *)fields
{
    return nil;
}

#pragma mark FFSerializableDelegate method

- (BOOL)deserialize:(NSString *)str
{
    return YES;
}

- (BOOL)deserialize:(NSString *)str startFrom:(int)offset
{
    return YES;
}

- (NSString *)serialize
{
    NSMutableString *destMutableStr = [[NSMutableString alloc] initWithCapacity:5];
    NSArray *fields = [self fields];
    for (id field in fields) {
        [destMutableStr appendFormat:@"%@", field];
    }
    NSString *result = (destMutableStr.length > 1) ? [destMutableStr substringToIndex:destMutableStr.length - 1] : nil;
    return result;
}

@end
