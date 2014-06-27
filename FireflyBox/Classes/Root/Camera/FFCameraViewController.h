//
//  FFCameraViewController.h
//  FireflyBox
//
//  Created by pig on 14-5-20.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseViewController.h"
#import <GPUImage/GPUImage.h>

@interface FFCameraViewController : FFBaseViewController<GPUImageVideoCameraDelegate>

@property (nonatomic, strong) NSString *movieWriterPath;

@property (nonatomic, strong) GPUImageView *backgroundGPUImageView;
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
//@property (nonatomic, strong) GPUImageOutput<GPUImageInput> *filter;
@property (nonatomic, strong) GPUImageBuffer *videoBuffer;
@property (nonatomic, strong) GPUImageMovieWriter *movieWriter;

@property (nonatomic, strong) UIButton *quitButton;
@property (nonatomic, strong) UIButton *recordButton;
@property (nonatomic, strong) UIButton *frontOrBackButton;

@property (nonatomic, assign) BOOL isRecording;

@end
