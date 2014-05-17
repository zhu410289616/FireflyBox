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

- (void)audioRecorder:(FFAudioRecorder *)audioRecorder didStart:(CAStreamBasicDescription)format name:(NSString*)name;
- (void)audioRecorder:(FFAudioRecorder *)audioRecorder didStop:(NSString *)savePath name:(NSString *)name;

@end

@interface FFAudioRecorder : NSObject

@property (readonly) AQRecorder *recorder;
@property (nonatomic, assign) BOOL playbackWasInterrupted;
@property (nonatomic, assign) BOOL playbackWasPaused;
@property (nonatomic, assign) BOOL inBackground;

@property (nonatomic, assign) id<FFAudioRecorderDelegate> delegate;

- (void)startRecord;
- (void)stopRecord;

@end
