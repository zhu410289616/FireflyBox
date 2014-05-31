//
//  FFPorgressLayer.h
//  FireflyBox
//
//  Created by pig on 14-5-31.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#define FFProgressKey (@"progress")

@interface FFPorgressLayer : CALayer

@property (assign) float progress;

- (void)updateProgress:(float)progress;

@end
