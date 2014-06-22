//
//  FFDeleteFileTask.m
//  FireflyBox
//
//  Created by pig on 14-5-18.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFDeleteFileTask.h"

@implementation FFDeleteFileTask

- (void)executeTask
{
    FFLOG_FORMAT(@"_filePath: %@", _filePath);
    
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:_filePath error:nil];
}

@end
