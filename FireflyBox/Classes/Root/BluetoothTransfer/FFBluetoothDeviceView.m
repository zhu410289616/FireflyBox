//
//  FFBluetoothDeviceView.m
//  FireflyBox
//
//  Created by pig on 14-5-31.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBluetoothDeviceView.h"
#import "FFCircularProgressLayer.h"

@implementation FFBluetoothDeviceView

+ (Class)layerClass
{
    return [FFCircularProgressLayer class];
}

- (void)updateProgress:(float)progress
{
    FFCircularProgressLayer *progressLayer = (FFCircularProgressLayer *)[self layer];
    progressLayer.progress = progress;
    [progressLayer setNeedsDisplay];
}

@end
