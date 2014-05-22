//
//  FFBaseRunnable.h
//  FireflyBox
//
//  Created by pig on 14-5-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseSerializable.h"
#import "FFRunnableDelegate.h"

const static NSString *Method_Post = @"POST";
const static NSString *Method_Get = @"GET";

@interface FFBaseRunnable : FFBaseObject<FFRunnableDelegate>

@property (nonatomic, weak) id<FFRunnableDelegate> delegate;

- (void)ajaxIn;
- (void)ajaxOut;
- (void)ajaxFail;

- (NSString *)getHttpURL;
- (NSString *)getHttpMethod;

@end
