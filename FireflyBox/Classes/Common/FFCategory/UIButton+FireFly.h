//
//  UIButton+FireFly.h
//  FireflyBox
//
//  Created by pig on 14-5-2.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    FFButtonStyleNormal,
    FFButtonStyleRound_60_60,
    FFButtonStyleItemAction,
    FFButtonStyleIcon
} FFButtonStyle;

@interface UIButton (FireFly)

+ (id)buttonWithStyle:(FFButtonStyle)buttonStyle;

- (void)styleWithCornerRadius:(float)radius;

- (void)styleWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)highlightedStyleWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

- (void)styleWithBackgroundColor:(UIColor *)color;
- (void)highlightedStyleWithBackgroundColor:(UIColor *)color;

@end
