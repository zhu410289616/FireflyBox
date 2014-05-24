//
//  FFHttpRunnable.m
//  FireflyBox
//
//  Created by pig on 14-5-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFHttpRunnable.h"

@implementation FFHttpRunnable

/**
 *  获取http的请求方式[GET, POST]
 *
 *  @return GET, POST 字符串
 */
- (NSString *)getHttpMethod
{
    return (NSString *)Method_Get;
}

/**
 *  获取http的请求地址
 *
 *  @return url 字符串
 */
- (NSString *)getHttpURL
{
    return nil;
}

/**
 *  获取http的请求参数
 *
 *  @return 字典类型的key=value
 */
- (NSDictionary *)getHttpParameters
{
    return nil;
}

/**
 *  获取http的文件数据参数
 *
 *  @return 字典类型的key=value
 */
- (NSDictionary *)getHttpMultipartFormDataParameters
{
    return nil;
}

@end
