//
//  FFHttpTask.m
//  FireflyBox
//
//  Created by pig on 14-5-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFHttpTask.h"
#import "FFHttpRunnable.h"
#import "AFNetworking.h"

@implementation FFHttpTask

#pragma mark override function

- (FFTaskQueueType)taskQueueType
{
    return FFTaskQueueTypeConcurrent;
}

- (void)execute
{
    [self doRequest];
}

#pragma mark private function

/**
 *  判断处理http请求类型
 */
- (void)doRequest
{
    if ([self.runnable isKindOfClass:[FFHttpRunnable class]]) {
        FFHttpRunnable *httpRunnable = (FFHttpRunnable *)self.runnable;
        if ([Method_Get isEqualToString:[httpRunnable httpMethod]]) {
            [self doGetRequest:httpRunnable];
        } else if ([Method_Post isEqualToString:[httpRunnable httpMethod]]) {
            [self doPostRequest:httpRunnable];
        } else if ([Method_Multi_Post isEqualToString:[httpRunnable httpMethod]]) {
            [self doMultiPostRequest:httpRunnable];
        } else {
            NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"Unknow Runnable class!"] code:0 userInfo:nil];
            [self.runnable ajaxFail:nil error:error];
        }
    } else {
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"Unknow Runnable class!"] code:0 userInfo:nil];
        [self.runnable ajaxFail:nil error:error];
    }
}

/**
 *  GET request
 */
- (void)doGetRequest:(FFHttpRunnable *)httpRunnable
{
    NSString *httpUrl = [httpRunnable httpURL];
    NSDictionary *param = [httpRunnable httpParameters];
    FFLOG_FORMAT(@"[GET] http url: %@, param: %@", httpUrl, param);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    [manager GET:httpUrl parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        FFLOG_FORMAT(@"[GET] JSON: %@", responseObject);
        httpRunnable.dicResult = responseObject;
        [httpRunnable ajaxOut:self];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        FFLOG_FORMAT(@"[GET] error: %@", error);
        [httpRunnable ajaxFail:self error:error];
    }];
}

/**
 *  POST URL-Form-Encoded Request
 */
- (void)doPostRequest:(FFHttpRunnable *)httpRunnable
{
    NSString *httpUrl = [httpRunnable httpURL];
    NSDictionary *param = [httpRunnable httpParameters];
    FFLOG_FORMAT(@"[POST] http url: %@, param: %@", httpUrl, param);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    [manager POST:httpUrl parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        FFLOG_FORMAT(@"[POST] JSON: %@", responseObject);
        httpRunnable.dicResult = responseObject;
        [httpRunnable ajaxOut:self];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        FFLOG_FORMAT(@"[POST] error: %@", error);
        [httpRunnable ajaxFail:self error:error];
    }];
}

/**
 *  Multi-Part Request
 */
- (void)doMultiPostRequest:(FFHttpRunnable *)httpRunnable
{
    NSString *httpUrl = [httpRunnable httpURL];
    NSDictionary *param = [httpRunnable httpParameters];
    NSDictionary *multipartFormDataParam = [httpRunnable httpMultipartFormDataParameters];
    FFLOG_FORMAT(@"[MULTI POST] http url: %@, param: %@, multipartFormDataParam: %@", httpUrl, param, multipartFormDataParam);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    [manager POST:httpUrl parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSArray *multipartParamKeys = [multipartFormDataParam allKeys];
        for (id key in multipartParamKeys) {
            id value = [multipartFormDataParam objectForKey:key];
            if ([value isKindOfClass:[NSURL class]]) {
                [formData appendPartWithFileURL:value name:key error:nil];
            }
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        FFLOG_FORMAT(@"[MULTI POST] JSON: %@", responseObject);
        httpRunnable.dicResult = responseObject;
        [httpRunnable ajaxOut:self];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        FFLOG_FORMAT(@"[MULTI POST] error: %@", error);
        [httpRunnable ajaxFail:self error:error];
    }];
}


@end
