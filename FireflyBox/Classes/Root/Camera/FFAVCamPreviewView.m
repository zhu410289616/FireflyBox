//
//  FFAVCamPreviewView.m
//  FireflyBox
//
//  Created by pig on 14-6-9.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFAVCamPreviewView.h"
#import <AVFoundation/AVFoundation.h>

@implementation FFAVCamPreviewView

+ (Class)layerClass
{
	return [AVCaptureVideoPreviewLayer class];
}

- (AVCaptureSession *)session
{
	return [(AVCaptureVideoPreviewLayer *)[self layer] session];
}

- (void)setSession:(AVCaptureSession *)session
{
	[(AVCaptureVideoPreviewLayer *)[self layer] setSession:session];
}

@end
