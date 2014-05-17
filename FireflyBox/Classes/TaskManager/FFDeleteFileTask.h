//
//  FFDeleteFileTask.h
//  FireflyBox
//
//  Created by pig on 14-5-18.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseTask.h"

@interface FFDeleteFileTask : FFBaseTask

@property (nonatomic, assign) long dataId;
@property (nonatomic, strong) NSString *filePath;

@end
