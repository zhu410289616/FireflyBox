//
//  FFConvertHelper.h
//  FireflyBox
//
//  Created by pig on 14-5-20.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FFAudioConvertStatusCaf2Mp3 = 1,
    FFAudioConvertStatusCaf2WAV
} FFAudioConvertStatus;

@interface FFConvertHelper : NSObject

+ (void)convertToMp3WithCafFilePath:(NSString *)tCafFilePath;
+ (void)convertCaf2Mp3:(NSString *)tSrcPath destPath:(NSString *)tDestPath;

@end
