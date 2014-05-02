//
//  UIImage+FireFly.m
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "UIImage+FireFly.h"

@implementation UIImage (FireFly)

//
+ (UIImage *)imageWithColor:(UIColor *)tColor size:(CGSize)tSize
{
    CGRect rect = CGRectMake(0, 0, tSize.width, tSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [tColor CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//
+ (UIImage *)imageWithName:(NSString *)tName
{
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:tName ofType:@"png"]];
}

+ (UIImage *)imageWithName:(NSString *)tName type:(NSString *)tType
{
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:tName ofType:tType]];
}

//将一个UIImage 缩放变换到指定Size的UIImage
+ (UIImage *)imageWithImage:(UIImage *)image scaleToSize:(CGSize)size
{
    //创建一个bitmap的context
    //并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    //绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    //从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
