//
//  FFBaseObject.m
//  FireflyBox
//
//  Created by pig on 14-5-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseObject.h"

@implementation FFBaseObject

- (NSString *)className
{
    return @"com.firefly.BaseObject";
}

- (NSMutableArray *)fields
{
    return [NSMutableArray arrayWithCapacity:5];
}

@end
