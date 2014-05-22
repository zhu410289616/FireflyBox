//
//  FFBaseRequest.h
//  FireflyBox
//
//  Created by pig on 14-5-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseTask.h"
#import "FFBaseRunnable.h"

@interface FFBaseRequest : FFBaseTask

@property (nonatomic, strong) FFBaseRunnable *runnable;

@end
