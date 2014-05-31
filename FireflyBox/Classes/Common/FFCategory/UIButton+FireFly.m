//
//  UIButton+FireFly.m
//  FireflyBox
//
//  Created by pig on 14-5-2.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "UIButton+FireFly.h"

@implementation UIButton (FireFly)

+ (id)buttonWithStyle:(FFButtonStyle)buttonStyle
{
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    switch (buttonStyle) {
        case FFButtonStyleRound_60_60:
            customButton.frame = CGRectMake(0, 0, 60, 60);
            [customButton styleWithCornerRadius:30.0f];
            break;
            
        default:
            break;
    }
    
    return customButton;
}

- (void)styleWithCornerRadius:(float)radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)styleWithTitle:(NSString *)title titleColor:(UIColor *)titleColor
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)highlightedStyleWithTitle:(NSString *)title titleColor:(UIColor *)titleColor
{
    [self setTitle:title forState:UIControlStateHighlighted];
    [self setTitleColor:titleColor forState:UIControlStateHighlighted];
}

- (void)styleWithBackgroundColor:(UIColor *)color
{
    [self setBackgroundImage:[UIImage imageWithColor:color size:CGSizeMake(2, 2)] forState:UIControlStateNormal];
}

- (void)highlightedStyleWithBackgroundColor:(UIColor *)color
{
    [self setBackgroundImage:[UIImage imageWithColor:color size:CGSizeMake(2, 2)] forState:UIControlStateHighlighted];
}

@end
