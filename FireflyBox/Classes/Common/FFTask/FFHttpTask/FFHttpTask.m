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

- (FFTaskQueueType)getFFTaskQueueType
{
    return FFTaskQueueTypeConcurrent;
}

- (void)executeTask
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
        if ([Method_Get isEqualToString:[httpRunnable getHttpMethod]]) {
            [self doGetRequest:httpRunnable];
        } else if ([Method_Post isEqualToString:[httpRunnable getHttpMethod]]) {
            [self doPostRequest:httpRunnable];
        } else if ([Method_Multi_Post isEqualToString:[httpRunnable getHttpMethod]]) {
            [self doMultiPostRequest:httpRunnable];
        }
    }
}

/**
 *  GET request
 */
- (void)doGetRequest:(FFHttpRunnable *)httpRunnable
{
    NSString *httpUrl = [httpRunnable getHttpURL];
    NSDictionary *param = [httpRunnable getHttpParameters];
    PLog(@"[GET] http url: %@, param: %@", httpUrl, param);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:httpUrl parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        PLog(@"JSON: %@", responseObject);
        [httpRunnable ajaxOut];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [httpRunnable ajaxFail];
    }];
}

/**
 *  POST URL-Form-Encoded Request
 */
- (void)doPostRequest:(FFHttpRunnable *)httpRunnable
{
    NSString *httpUrl = [httpRunnable getHttpURL];
    NSDictionary *param = [httpRunnable getHttpParameters];
    PLog(@"[POST] http url: %@, param: %@", httpUrl, param);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:httpUrl parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        PLog(@"JSON: %@", responseObject);
        [httpRunnable ajaxOut];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [httpRunnable ajaxFail];
    }];
}

/**
 *  Multi-Part Request
 */
- (void)doMultiPostRequest:(FFHttpRunnable *)httpRunnable
{
    NSString *httpUrl = [httpRunnable getHttpURL];
    NSDictionary *param = [httpRunnable getHttpParameters];
    NSDictionary *multipartFormDataParam = [httpRunnable getHttpMultipartFormDataParameters];
    PLog(@"[MULTI POST] http url: %@, param: %@, multipartFormDataParam: %@", httpUrl, param, multipartFormDataParam);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:httpUrl parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSArray *multipartParamKeys = [multipartFormDataParam allKeys];
        for (id key in multipartParamKeys) {
            id value = [multipartFormDataParam objectForKey:key];
            if ([value isKindOfClass:[NSURL class]]) {
                [formData appendPartWithFileURL:value name:key error:nil];
            }
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [httpRunnable ajaxOut];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [httpRunnable ajaxFail];
    }];
}


@end
