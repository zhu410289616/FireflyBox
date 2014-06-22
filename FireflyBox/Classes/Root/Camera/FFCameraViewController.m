//
//  FFCameraViewController.m
//  FireflyBox
//
//  Created by pig on 14-5-20.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFCameraViewController.h"

@interface FFCameraViewController ()

@end

@implementation FFCameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.backgroundGPUImageView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.backgroundGPUImageView];
    
    //
    self.quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.quitButton.frame = CGRectMake(5, GLOBAL_SCREEN_HEIGHT - 55, 100, 50);
    [self.quitButton setTitle:@"退出" forState:UIControlStateNormal];
    [self.quitButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.quitButton addTarget:self action:@selector(doQuitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.quitButton];
    
    self.recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recordButton.frame = CGRectMake(200, GLOBAL_SCREEN_HEIGHT - 55, 100, 50);
    [self.recordButton setTitle:@"开始" forState:UIControlStateNormal];
    [self.recordButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.recordButton setImage:[UIImage imageNamed:@"RecordDot.png"] forState:UIControlStateNormal] ;
    [self.recordButton addTarget:self action:@selector(doVideoRecordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.recordButton];
    
    //
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionBack];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.horizontallyMirrorFrontFacingCamera = YES;
    self.videoCamera.horizontallyMirrorRearFacingCamera = NO;
    
    //
    self.videoBuffer = [[GPUImageBuffer alloc] init];
    self.videoBuffer.bufferSize = 1;
    [self.videoBuffer addTarget:self.backgroundGPUImageView];
    //
    [self.videoCamera addTarget:self.videoBuffer];
    [self.videoCamera startCameraCapture];
    
    //init path
    [self initMovieWriterDir];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark privte function

- (void)initMovieWriterDir
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    self.movieWriterPath = [FFCommonUtil createPath:[NSString stringWithFormat:@"%@%@/", documentsPath, MOVIE_WRITER_SAVE_DIR]];
}

- (IBAction)doQuitAction:(id)sender
{
    if (self.isRecording) {
        [self doVideoRecordAction:nil];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doVideoRecordAction:(id)sender
{
    if (self.isRecording) {
        self.isRecording = NO;
        [self.videoCamera removeTarget:self.movieWriter];
        [self.movieWriter finishRecording];
        
        [self.recordButton setImage:[UIImage imageNamed:@"RecordDot.png"] forState:UIControlStateNormal] ;
        [self.recordButton setTitle:@"开始" forState:UIControlStateNormal];
    } else {
        self.isRecording = YES;
        NSString *pathForMovie = [NSString stringWithFormat:@"%@%@.m4v", self.movieWriterPath, [NSString stringWithDate:[NSDate date] formatter:@"yyyy-MM-dd-HHmmss"]];
        NSURL *movieURL = [NSURL fileURLWithPath:pathForMovie];
        self.movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:self.backgroundGPUImageView.frame.size];
        [self.videoCamera addTarget:self.movieWriter];
        [self.movieWriter startRecording];
        
        [self.recordButton setImage:[UIImage imageNamed:@"RecordStop.png"] forState:UIControlStateNormal] ;
        [self.recordButton setTitle:@"停止" forState:UIControlStateNormal];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // Map UIDeviceOrientation to UIInterfaceOrientation.
    UIInterfaceOrientation orient = UIInterfaceOrientationPortrait;
    switch ([[UIDevice currentDevice] orientation])
    {
        case UIDeviceOrientationLandscapeLeft:
            orient = UIInterfaceOrientationLandscapeLeft;
            break;
            
        case UIDeviceOrientationLandscapeRight:
            orient = UIInterfaceOrientationLandscapeRight;
            break;
            
        case UIDeviceOrientationPortrait:
            orient = UIInterfaceOrientationPortrait;
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            orient = UIInterfaceOrientationPortraitUpsideDown;
            break;
            
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationUnknown:
            // When in doubt, stay the same.
            orient = fromInterfaceOrientation;
            break;
    }
    self.videoCamera.outputImageOrientation = orient;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES; // Support all orientations.
}

@end
