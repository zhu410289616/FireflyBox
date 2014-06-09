//
//  FFAVCamPreviewView.h
//  FireflyBox
//
//  Created by pig on 14-6-9.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVCaptureSession;

@interface FFAVCamPreviewView : UIView

@property (nonatomic) AVCaptureSession *session;

@end
