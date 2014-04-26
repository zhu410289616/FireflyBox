//
//  UIImage+FireFly.h
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FireFly)

+ (UIImage *)imageWithColor:(UIColor *)tColor size:(CGSize)tSize;

+ (UIImage *)imageWithName:(NSString *)tName;
+ (UIImage *)imageWithName:(NSString *)tName type:(NSString *)tType;

+ (UIImage *)imageWithImage:(UIImage *)image scaleToSize:(CGSize)size;

@end
