//
//  FFAudioRecorderViewController.m
//  FireflyBox
//
//  Created by pig on 14-5-16.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFAudioRecorderViewController.h"
#import "FFBarButtonItem.h"
#import <AudioToolbox/AudioToolbox.h>
#import "FFConvertHelper.h"

@interface FFAudioRecorderViewController ()

@end

@implementation FFAudioRecorderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"录音";
    
    FFBarButtonItem *tempBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = tempBarButtonItem;
    
    UIColor *bgColor = [UIColor colorWithRed:.39 green:.44 blue:.57 alpha:.5];
    _lvlMeter_in = [[AQLevelMeter alloc] initWithFrame:CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, 100)];
	[_lvlMeter_in setBackgroundColor:bgColor];
	[_lvlMeter_in setBorderColor:bgColor];
    [self.view addSubview:_lvlMeter_in];
    
    //文件名称
    _fileNameLabel = [[UILabel alloc] init];
    _fileNameLabel.frame = CGRectMake(15, CGRectGetMaxY(_lvlMeter_in.frame) + 20, GLOBAL_SCREEN_WIDTH - 30, 30);
    _fileNameLabel.text = @"录音文件名称";
    _fileNameLabel.hidden = YES;
    [self.view addSubview:_fileNameLabel];
    
    //
    _fileDescription = [[UILabel alloc] init];
    _fileDescription.frame = CGRectMake(15, CGRectGetMaxY(_fileNameLabel.frame) + 20, GLOBAL_SCREEN_WIDTH - 30, 30);
    _fileDescription.text = @"file description";
    _fileDescription.hidden = YES;
    [self.view addSubview:_fileDescription];
    
    //录音时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.frame = CGRectMake(15, CGRectGetMaxY(_fileDescription.frame) + 20, GLOBAL_SCREEN_WIDTH - 30, 30);
    _timeLabel.text = @"录音时间: 0 秒";
    _timeLabel.hidden = YES;
    [self.view addSubview:_timeLabel];
    
    //
    _recorderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _recorderButton.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - 57 - 64, GLOBAL_SCREEN_WIDTH, 57);
    _recorderButton.tag = 100;//开始录音
    _recorderButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _recorderButton.titleLabel.font = [UIFont fontWithBoldOfApp:19.0f];
    [_recorderButton styleWithTitle:@"开始录音" titleColor:[UIColor colorWithHex:0x157dfb]];
    [_recorderButton styleWithBackgroundColor:[UIColor colorWithHex:0xf8f8f8]];
    [_recorderButton highlightedStyleWithBackgroundColor:[UIColor colorWithHex:0xd9d9d9]];
    [_recorderButton addTarget:self action:@selector(doRecordStartAndStop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_recorderButton];
    
    //
    _audioRecorder = [[FFAudioRecorder alloc] init];
    _audioRecorder.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    GLOBAL_APP.idleTimerDisabled = YES;//不自动锁屏
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    GLOBAL_APP.idleTimerDisabled = NO;//自动锁屏
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doRightBarButtonItemAction:(id)sender
{
    [_audioRecorder stopRecord];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)doRecordStartAndStop:(id)sender
{
    @synchronized(self) {
        UIButton *recordButton = sender;
        if (recordButton.tag == 100) {
            recordButton.tag = 200;
            [recordButton styleWithTitle:@"结束录音" titleColor:[UIColor colorWithHex:0x157dfb]];
            [_audioRecorder startRecord];
        } else {
            recordButton.tag = 100;
            [recordButton styleWithTitle:@"开始录音" titleColor:[UIColor colorWithHex:0x157dfb]];
            [_audioRecorder stopRecord];
        }
    }
}

#pragma mark FFAudioRecorderDelegate method

- (void)audioRecorder:(FFAudioRecorder *)audioRecorder didStart:(NSString *)fileDescription name:(NSString *)name
{
    // Hook the level meter up to the Audio Queue for the recorder
    [_lvlMeter_in setAq:audioRecorder.recorder->Queue()];
    _fileNameLabel.text = name;
    _fileNameLabel.hidden = NO;
    _fileDescription.text = fileDescription;
    _fileDescription.hidden = NO;
}

- (void)audioRecorder:(FFAudioRecorder *)audioRecorder didRecording:(int)recordTime
{
    _timeLabel.text = [NSString stringWithFormat:@"录音时间: %d 秒", recordTime];
    _timeLabel.hidden = NO;
}

- (void)audioRecorder:(FFAudioRecorder *)audioRecorder didStop:(NSString *)savePath name:(NSString *)name
{
    // Disconnect our level meter from the audio queue
	[_lvlMeter_in setAq:nil];
    
    [[FFConvertHelper sharedInstance] toMp3WithCafFilePath:savePath];
    
}

@end
