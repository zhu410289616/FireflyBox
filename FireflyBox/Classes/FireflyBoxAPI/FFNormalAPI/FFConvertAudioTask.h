//
//  FFConvertAudioTask.h
//  FireflyBox
//
//  Created by pig on 14-5-22.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBoxTask.h"
#import "FFConvertHelper.h"

@interface FFConvertAudioTask : FFBoxTask

@property (nonatomic, strong) NSString *srcPath;
@property (nonatomic, strong) NSString *destPath;
@property (nonatomic, assign) FFAudioConvertStatus audioConvertStatus;

@end
