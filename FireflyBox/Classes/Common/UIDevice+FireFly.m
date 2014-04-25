//
//  UIDevice+FireFly.m
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "UIDevice+FireFly.h"

@implementation UIDevice (FireFly)

- (BOOL)isRetinaScreen
{
    CGFloat scale = 1.0f;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        scale = [[UIScreen mainScreen] scale];
    }
    if (fabsf(scale - 2.0f) < FLT_EPSILON) {
        return YES;
    }
    return NO;
}

- (float)screenScale
{
    CGFloat scale = 1.0f;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        scale = [[UIScreen mainScreen] scale];
    }
    return scale;
}

@end
