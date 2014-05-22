//
//  FFConvertAudioTask.h
//  FireflyBox
//
//  Created by pig on 14-5-22.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseTask.h"
#import "FFConvertHelper.h"

@interface FFConvertAudioTask : FFBaseTask

@property (nonatomic, strong) NSString *srcPath;
@property (nonatomic, strong) NSString *destPath;
@property (nonatomic, assign) FFAudioConvertStatus audioConvertStatus;

@end
