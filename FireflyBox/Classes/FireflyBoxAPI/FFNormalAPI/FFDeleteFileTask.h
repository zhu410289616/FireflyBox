//
//  FFDeleteFileTask.h
//  FireflyBox
//
//  Created by pig on 14-5-18.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBoxTask.h"

@interface FFDeleteFileTask : FFBoxTask

@property (nonatomic, assign) long dataId;
@property (nonatomic, strong) NSString *filePath;

@end
