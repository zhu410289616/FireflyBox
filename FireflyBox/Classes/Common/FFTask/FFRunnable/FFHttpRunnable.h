//
//  FFHttpRunnable.h
//  FireflyBox
//
//  Created by pig on 14-5-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseRunnable.h"

const static NSString *Method_Get = @"GET";
const static NSString *Method_Post = @"POST";
const static NSString *Method_Multi_Post = @"MULTI_POST";

@interface FFHttpRunnable : FFBaseRunnable

/**
 *  获取http的请求方式[GET, POST]
 *
 *  @return GET, POST 字符串
 */
- (NSString *)getHttpMethod;

/**
 *  获取http的请求地址
 *
 *  @return url 字符串
 */
- (NSString *)getHttpURL;

/**
 *  获取http的请求参数
 *
 *  @return 字典类型的key=value
 */
- (NSDictionary *)getHttpParameters;

/**
 *  获取http的文件数据参数
 *
 *  @return 字典类型的key=value
 */
- (NSDictionary *)getHttpMultipartFormDataParameters;

@end