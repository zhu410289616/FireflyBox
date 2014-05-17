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
        
        NSString *recordFileName = [NSString stringWithFormat:@"%@.caf", [NSString stringWithDate:[NSDate date] formatter:@"yyyy-MM-dd-HHmmss"]];
		// Start the recorder
		_recorder->StartRecord((__bridge CFStringRef)recordFileName, (__bridge CFStringRef)_audioRecorderPath);
		
		[self setFileDescriptionForFormat:_recorder->DataFormat() withName:@"Recorded File"];
		
        if (_delegate) {
            [_delegate audioRecorder:self didStart:_recorder->DataFormat() name:@"Recorded File"];
        }
        
	}
}

- (void)stopRecord
{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error: nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    if (_delegate) {
        [_delegate audioRecorder:self didStop:nil name:nil];
    }
    if (_recorder->IsRunning()) {
        _recorder->StopRecord();
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

- (void)setFileDescriptionForFormat: (CAStreamBasicDescription)format withName:(NSString*)name
{
	char buf[5];
	const char *dataFormat = OSTypeToStr(buf, format.mFormatID);
	NSString *description = [NSString stringWithFormat:@"(%ld ch. %s @ %g Hz)", format.NumberChannels(), dataFormat, format.mSampleRate, nil];
	PLog(@"description: %@", description);
}

@end
