//
//  FFConvertAudioTask.m
//  FireflyBox
//
//  Created by pig on 14-5-22.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFConvertAudioTask.h"

@implementation FFConvertAudioTask

- (void)executeTask
{
    [self convertAudio:_audioConvertStatus srcPath:_srcPath destPath:_destPath];
}

- (void)convertAudio:(FFAudioConvertStatus)tAudioConvertStatus srcPath:(NSString *)tSrcPath destPath:(NSString *)tDestPath
{
    if (!tSrcPath || tSrcPath.length < 1 || !tDestPath || tDestPath.length < 1) {
        return;
    }
    
    switch (tAudioConvertStatus) {
        case FFAudioConvertStatusCaf2Mp3:
            [FFConvertHelper convertCaf2Mp3:tSrcPath destPath:tDestPath];
            break;
            
        default:
            break;
    }
}

@end
