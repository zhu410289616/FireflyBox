//
//  UIColor+FireFly.h
//  FFRunner
//
//  Created by pig on 14-3-28.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FireFly)

//0x000000 - 0xffffff
+ (UIColor *)colorWithHex:(NSInteger)tHexValue alpha:(CGFloat)tAlphaValue;
+ (UIColor *)colorWithHex:(NSInteger)tHexValue;

@end
