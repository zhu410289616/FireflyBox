//
//  FFBaseRunnable.m
//  FireflyBox
//
//  Created by pig on 14-5-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseRunnable.h"

@implementation FFBaseRunnable

- (void)ajaxIn
{
}

- (void)ajaxOut
{}

- (void)ajaxFail
{}

- (NSString *)getHttpURL
{
    return @"FFBaseRunnable";
}

- (NSString *)getHttpMethod
{
    return (NSString *)Method_Post;
}

@end
