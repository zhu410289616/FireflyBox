//
//  FFHttpRunnable.m
//  FireflyBox
//
//  Created by pig on 14-5-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFHttpRunnable.h"

@implementation FFHttpRunnable

#pragma mark override function

- (void)ajaxIn:(id)aTask
{
    //todo
}

- (void)ajaxOut:(id)aTask
{
    //todo
}

- (void)ajaxFail:(id)aTask error:(NSError *)error
{
    //todo
}

#pragma mark implement function

/**
 *  获取http的请求方式[GET, POST]
 *
 *  @return GET, POST 字符串
 */
- (NSString *)httpMethod
{
    return (NSString *)Method_Get;
}

/**
 *  获取http的请求地址
 *
 *  @return url 字符串
 */
- (NSString *)httpURL
{
    return nil;
}

/**
 *  获取http的请求参数
 *
 *  @return 字典类型的key=value
 */
- (NSDictionary *)httpParameters
{
    return nil;
}

/**
 *  获取http的文件数据参数
 *
 *  @return 字典类型的key=value
 */
- (NSDictionary *)httpMultipartFormDataParameters
{
    return nil;
}

@end
