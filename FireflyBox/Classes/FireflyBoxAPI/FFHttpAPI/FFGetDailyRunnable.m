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

- (NSString *)httpMethod
{
    return (NSString *)Method_Post;
}

- (NSString *)httpURL
{
    return [NSString stringWithFormat:@"%@%@", WEBSERVICE_DOMAIN, WEBSERVICE_GET_DAILY_TEXT];
}

@end
