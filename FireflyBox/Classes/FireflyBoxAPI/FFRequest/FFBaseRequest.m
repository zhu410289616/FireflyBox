//
//  FFBaseRequest.m
//  FireflyBox
//
//  Created by pig on 14-5-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseRequest.h"
#import "AFHTTPRequestOperation.h"

@implementation FFBaseRequest

- (void)executeTask
{
    [self doRequest];
}

- (void)doRequest
{
    if ([Method_Get isEqualToString:[_runnable getHttpMethod]]) {
        [self doGetRequest];
    } else if ([Method_Post isEqualToString:[_runnable getHttpMethod]]) {
        [self doPostRequest];
    }
}

- (void)doGetRequest
{
    NSString *getHttpUrl = [_runnable getHttpURL];
    PLog(@"[GET] http url: %@", getHttpUrl);
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:getHttpUrl]];
    
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        @try {
            
            NSDictionary* dicJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            PLog(@"dicJson: %@", dicJson);
            
            if (_runnable) {
                [_runnable ajaxOut];
            }
            
        }
        @catch (NSException *exception) {
            [_runnable ajaxFail];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PLog(@"get guest failure: %@", error);
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNameGetUserInfoFailed object:nil userInfo:nil];
        
    }];
    
    [operation start];
}

- (void)doPostRequest
{
    
}

@end
