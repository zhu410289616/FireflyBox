//
//  FFAudioRecorder.m
//  FireflyBox
//
//  Created by pig on 14-5-17.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFAudioRecorder.h"

@implementation FFAudioRecorder

- (void)dealloc
{
    [self removeForBackgroundNotifications];
}

- (id)init
{
    if (self = [super init]) {
        // Allocate our singleton instance for the recorder & player object
        _recorder = new AQRecorder();
        
        /**
         * 使用ARC，参数不一致，应该为
         * AudioSessionInitialize(NULL, NULL, interruptionListener, (__bridge void*)self);
         */
        OSStatus error = AudioSessionInitialize(NULL, NULL, interruptionListener, (__bridge void*)self);
        if (error) {
            PLog(@"ERROR INITIALIZING AUDIO SESSION! %d\n", (int)error);
        }
        else
        {
            UInt32 category = kAudioSessionCategory_PlayAndRecord;
            error = AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
            if (error) printf("couldn't set audio category!");
            
            error = AudioSessionAddPropertyListener(kAudioSessionProperty_AudioRouteChange, propListener, (__bridge void*)self);
            if (error) printf("ERROR ADDING AUDIO SESSION PROP LISTENER! %d\n", (int)error);
            UInt32 inputAvailable = 0;
            UInt32 size = sizeof(inputAvailable);
            
            // we do not want to allow recording if input is not available
            error = AudioSessionGetProperty(kAudioSessionProperty_AudioInputAvailable, &size, &inputAvailable);
            if (error) printf("ERROR GETTING INPUT AVAILABILITY! %d\n", (int)error);
            
            // we also need to listen to see if input availability changes
            error = AudioSessionAddPropertyListener(kAudioSessionProperty_AudioInputAvailable, propListener, (__bridge void*)self);
            if (error) printf("ERROR ADDING AUDIO SESSION PROP LISTENER! %d\n", (int)error);
            
            error = AudioSessionSetActive(true);
            if (error) printf("AudioSessionSetActive (true) failed");
        }
        
        [self registerForBackgroundNotifications];
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
		// Start the recorder
		_recorder->StartRecord(CFSTR("recordedFile.caf"));
		
		[self setFileDescriptionForFormat:_recorder->DataFormat() withName:@"Recorded File"];
		
        if (_delegate) {
            [_delegate audioRecorder:self didStart:_recorder->DataFormat() name:@"Recorded File"];
        }
        
	}
}

- (void)stopRecord
{
    if (_delegate) {
        [_delegate audioRecorder:self didStop:nil name:nil];
    }
	_recorder->StopRecord();
}

#pragma mark privte function

#pragma mark background notifications

- (void)registerForBackgroundNotifications
{
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(resignActive)
												 name:UIApplicationWillResignActiveNotification
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(enterForeground)
												 name:UIApplicationWillEnterForegroundNotification
											   object:nil];
}

- (void)resignActive
{
    if (_recorder->IsRunning()) {
        [self stopRecord];
    }
}

- (void)enterForeground
{
    OSStatus error = AudioSessionSetActive(true);
    if (error) {
        PLog(@"AudioSessionSetActive (true) failed");
    }
}

- (void)removeForBackgroundNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

#pragma mark AudioSession listeners

void interruptionListener(	void *	inClientData,
                          UInt32	inInterruptionState)
{
	FFAudioRecorder *THIS = (__bridge FFAudioRecorder*)inClientData;
	if (inInterruptionState == kAudioSessionBeginInterruption)
	{
		if (THIS->_recorder->IsRunning()) {
			[THIS stopRecord];
		}
	}
}

void propListener(	void *                  inClientData,
                  AudioSessionPropertyID	inID,
                  UInt32                  inDataSize,
                  const void *            inData)
{
	FFAudioRecorder *THIS = (__bridge FFAudioRecorder*)inClientData;
	if (inID == kAudioSessionProperty_AudioRouteChange)
	{
		CFDictionaryRef routeDictionary = (CFDictionaryRef)inData;
		//CFShow(routeDictionary);
		CFNumberRef reason = (CFNumberRef)CFDictionaryGetValue(routeDictionary, CFSTR(kAudioSession_AudioRouteChangeKey_Reason));
		SInt32 reasonVal;
		CFNumberGetValue(reason, kCFNumberSInt32Type, &reasonVal);
		if (reasonVal != kAudioSessionRouteChangeReason_CategoryChange)
		{
			// stop the queue if we had a non-policy route change
			if (THIS->_recorder->IsRunning()) {
				[THIS stopRecord];
			}
		}
	}
	else if (inID == kAudioSessionProperty_AudioInputAvailable)
	{
		if (inDataSize == sizeof(UInt32)) {
			UInt32 isAvailable = *(UInt32*)inData;
			// disable recording if input is not available
//			THIS->btn_record.enabled = (isAvailable > 0) ? YES : NO;
            
		}
	}
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
