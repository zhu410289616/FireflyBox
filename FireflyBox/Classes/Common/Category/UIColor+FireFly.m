//
//  UIColor+FireFly.m
//  FFRunner
//
//  Created by pig on 14-3-28.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "UIColor+FireFly.h"

@implementation UIColor (FireFly)

+ (UIColor *)colorWithHex:(NSInteger)tHexValue alpha:(CGFloat)tAlphaValue
{
    float redValue = ((tHexValue & 0xFF0000) >> 16) / 255.0f;
    float greenValue = ((tHexValue & 0xFF00) >> 8) / 255.0f;
    float blueValue = (tHexValue & 0xFF) / 255.0f;
    return [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:tAlphaValue];
}

+ (UIColor *)colorWithHex:(NSInteger)tHexValue
{
    return [UIColor colorWithHex:tHexValue alpha:1.0f];
}

@end
