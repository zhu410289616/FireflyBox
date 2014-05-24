//
//  FFGetDailyRunnable.m
//  FireflyBox
//
//  Created by pig on 14-5-25.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFGetDailyRunnable.h"
#import "FFBoxConfig.h"

@implementation FFGetDailyRunnable

- (NSString *)getHttpMethod
{
    return (NSString *)Method_Post;
}

- (NSString *)getHttpURL
{
    return [NSString stringWithFormat:@"%@%@", WEBSERVICE_DOMAIN, WEBSERVICE_GET_DAILY_TEXT];
}

@end
