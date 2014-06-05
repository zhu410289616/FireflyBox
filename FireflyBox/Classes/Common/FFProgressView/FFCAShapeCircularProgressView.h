//
//  FFCAShapeCircularProgressView.h
//  FireflyBox
//
//  Created by pig on 14-6-5.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFCAShapeCircularProgressView : UIView
{
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
    CAShapeLayer *_progressLayer;
    UIBezierPath *_progressPath;
}

@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic, assign) float progress;//value: 0-1
@property (nonatomic, assign) float progressWidth;

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
