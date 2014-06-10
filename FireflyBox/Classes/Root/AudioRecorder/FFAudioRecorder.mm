//
//  FFAudioRecorder.m
//  FireflyBox
//
//  Created by pig on 14-5-17.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFAudioRecorder.h"
#import <AVFoundation/AVFoundation.h>

@implementation FFAudioRecorder

- (void)dealloc
{
    [self removeForBackgroundNotifications];
}

- (id)init
{
    if (self = [super init]) {
        
        [self initAudioRecorderDir];
        
        [self registerForBackgroundNotifications];
        
        // Allocate our singleton instance for the recorder & player object
        _recorder = new AQRecorder();
        
    }
    return self;
}

#pragma mark function

#pragma mark public function

- (void)startRecord
{
    if (_recorder->IsRunning()) // If we are currently recording, stop and save the file.
	{
		[self stopRecord];
	}
	else // If we're not recording, start.
	{
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error: nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        
        _recordTime = 0;
        _recordTimeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(recording) userInfo:nil repeats:YES];
        
        NSString *recordFileName = [NSString stringWithFormat:@"%@.caf", [NSString stringWithDate:[NSDate date] formatter:@"yyyy-MM-dd-HHmmss"]];
		// Start the recorder
		_recorder->StartRecord((__bridge CFStringRef)recordFileName, (__bridge CFStringRef)_audioRecorderPath);
		
        char buf[5];
        const char *dataFormat = OSTypeToStr(buf, _recorder->DataFormat().mFormatID);
        NSString *description = [NSString stringWithFormat:@"(%ld ch. %s @ %g Hz)", _recorder->DataFormat().NumberChannels(), dataFormat, _recorder->DataFormat().mSampleRate, nil];
        FFLog(@"description: %@", description);
		
        if (_delegate) {
            [_delegate audioRecorder:self didStart:description name:recordFileName];
        }
        
	}
}

- (void)stopRecord
{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error: nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    if (_recordTimeTimer) {
        [_recordTimeTimer invalidate];
        _recordTimeTimer = nil;
    }
    
    if (_delegate) {
        NSString *cafFilePath = [NSString stringWithFormat:@"%@%@", _audioRecorderPath, (__bridge NSString *)_recorder->GetFileName()];
        [_delegate audioRecorder:self didStop:cafFilePath name:nil];
    }
    if (_recorder->IsRunning()) {
        _recorder->StopRecord();
    }
}

- (void)recording
{
    _recordTime++;
    
    if (_delegate) {
        [_delegate audioRecorder:self didRecording:_recordTime];
    }
}

#pragma mark privte function

- (void)initAudioRecorderDir
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _audioRecorderPath = [FFCommonUtil createPath:[NSString stringWithFormat:@"%@%@/", documentsPath, AUDIO_RECORDER_SAVE_DIR]];
}

#pragma mark background notifications

- (void)registerForBackgroundNotifications
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopRecord) name:UIApplicationWillResignActiveNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopRecord) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)removeForBackgroundNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

char *OSTypeToStr(char *buf, OSType t)
{
	char *p = buf;
	char str[4] = {0};
    char *q = str;
	*(UInt32 *)str = CFSwapInt32(t);
	for (int i = 0; i < 4; ++i) {
		if (isprint(*q) && *q != '\\')
			*p++ = *q++;
		else {
			sprintf(p, "\\x%02x", *q++);
			p += 4;
		}
	}
	*p = '\0';
	return buf;
}

@end
