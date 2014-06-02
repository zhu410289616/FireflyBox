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

/**
 *  将一个UIImage 缩放变换到指定Size的UIImage
 *
 *  @param image image
 *  @param size  图片缩放到的大小
 *
 *  @return image
 */
+ (UIImage *)imageWithImage:(UIImage *)image scaleToSize:(CGSize)size;

/**
 *  合并图片，把mergerImage覆盖到原有图片上
 *
 *  @param mergerImage 覆盖图片
 *
 *  @return image
 */
- (UIImage *)imageWithMergerImage:(UIImage *)mergerImage;

/**
 *  制作图片遮罩
 *
 *  @param baseImage 需要是带alpha通道的图片
 *  @param maskImage 不带alpha通道的遮罩图
 *
 *  @return image
 */
+ (UIImage *)imageByMask:(UIImage *)tBaseImage maskImage:(UIImage *)tMaskImage;

/**
 *  带有alpha通道的圆盘图片
 *
 *  @param imageSize
 *  @param progress  value: [0-1]
 *
 *  @return uiimage
 */
+ (UIImage *)imageWithCircularProcess:(CGSize)imageSize progress:(float)progress;

/**
 *  没有alpha通道的圆盘图片
 *
 *  @param imageSize imageSize description
 *  @param progress  value:[0-1]
 *
 *  @return uiimage
 */
+ (UIImage *)imageWithCircularProcessNoneAlpha:(CGSize)imageSize progress:(float)progress;

@end
