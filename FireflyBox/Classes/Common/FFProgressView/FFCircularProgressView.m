//
//  FFCircularProgressView.m
//  FireflyBox
//
//  Created by pig on 14-5-31.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFCircularProgressView.h"
#import "FFCircularProgressLayer.h"

@implementation FFCircularProgressView

+ (Class)layerClass
{
    return [FFCircularProgressLayer class];
}

- (void)updateProgress:(float)progress
{
    FFCircularProgressLayer *progressLayer = (FFCircularProgressLayer *)[self layer];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.fromValue = @0;
    animation.toValue = @50;
    animation.duration = 20;
    animation.fillMode = kCAFillModeForwards;
    
    CAKeyframeAnimation *anime = [CAKeyframeAnimation animation];
    anime.keyTimes = @[@0, @1];
    anime.values =   @[@0, @1];
    anime.timingFunctions = @[
                              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                              ];
    anime.duration = 30;
    anime.fillMode = kCAFillModeForwards;
    
//    [progressLayer addAnimation:anime forKey:FFProgressKey];
    
    progressLayer.progress = progress;
    [progressLayer setNeedsDisplay];
}

@end
