//
//  FFAVCamViewController.h
//  FireflyBox
//
//  Created by pig on 14-6-9.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseViewController.h"
#import "FFAVCamPreviewView.h"
#import <AVFoundation/AVFoundation.h>

@interface FFAVCamViewController : FFBaseViewController<AVCaptureFileOutputRecordingDelegate>

@property (nonatomic, strong) FFAVCamPreviewView *previewView;
@property (nonatomic, strong) UIButton *recordButton;
@property (nonatomic, strong) UIButton *cameraButton;
@property (nonatomic, strong) UIButton *stillButton;

/**
 *  init view
 */
- (void)viewDidLoadAction;

- (IBAction)toggleMovieRecording:(id)sender;
- (IBAction)changeCamera:(id)sender;
- (IBAction)snapStillImage:(id)sender;
- (IBAction)focusAndExposeTap:(UIGestureRecognizer *)gestureRecognizer;

@end
