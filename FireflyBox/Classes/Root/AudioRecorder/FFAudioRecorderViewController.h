//
//  FFAudioRecorderViewController.h
//  FireflyBox
//
//  Created by pig on 14-5-16.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseViewController.h"
#import "AQLevelMeter.h"
#import "FFAudioRecorder.h"

@interface FFAudioRecorderViewController : FFBaseViewController<FFAudioRecorderDelegate>

@property (nonatomic, strong) AQLevelMeter *lvlMeter_in;
@property (nonatomic, strong) UILabel *fileNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *fileDescription;
@property (nonatomic, strong) UIButton *recorderButton;

@property (nonatomic, strong) FFAudioRecorder *audioRecorder;

@end
