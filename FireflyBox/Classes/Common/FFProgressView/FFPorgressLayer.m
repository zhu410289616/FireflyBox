//
//  FFPorgressLayer.m
//  FireflyBox
//
//  Created by pig on 14-5-31.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFPorgressLayer.h"

@implementation FFPorgressLayer

- (void)updateProgress:(float)progress
{
    self.progress = progress;
    [self setNeedsDisplay];
}

@end
