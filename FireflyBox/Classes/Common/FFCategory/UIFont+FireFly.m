//
//  UIFont+FireFly.m
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "UIFont+FireFly.h"

@implementation UIFont (FireFly)

+ (void)showAllFont
{
    NSArray *familyNames = [UIFont familyNames];
    for (id obj in familyNames) {
        NSLog(@"obj: %@", obj);
    }
}

+ (UIFont *)fontOfApp:(CGFloat)tFontSize
{
    return [UIFont fontWithName:@"Helvetica Neue" size:tFontSize];
}

+ (UIFont *)fontWithBoldOfApp:(CGFloat)tFontSize
{
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:tFontSize];
}

@end
