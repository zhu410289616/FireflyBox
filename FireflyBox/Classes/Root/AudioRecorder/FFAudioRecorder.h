//
//  FFAudioRecorder.h
//  FireflyBox
//
//  Created by pig on 14-5-17.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQRecorder.h"

@class FFAudioRecorder;

@protocol FFAudioRecorderDelegate <NSObject>

- (void)audioRecorder:(FFAudioRecorder *)audioRecorder didStart:(NSString *)fileDescription name:(NSString*)name;
- (void)audioRecorder:(FFAudioRecorder *)audioRecorder didRecording:(int)recordTime;
- (void)audioRecorder:(FFAudioRecorder *)audioRecorder didStop:(NSString *)savePath name:(NSString *)name;

@end

@interface FFAudioRecorder : NSObject

@property (nonatomic, strong) NSString *audioRecorderPath;
@property (readonly) AQRecorder *recorder;

/**
 * 计时器，刷新录音时间
 */
@property (nonatomic, strong) NSTimer *recordTimeTimer;
@property (nonatomic, assign) int recordTime;//录音时间，单位秒（s）

@property (nonatomic, assign) id<FFAudioRecorderDelegate> delegate;

- (void)startRecord;
- (void)stopRecord;

@end
