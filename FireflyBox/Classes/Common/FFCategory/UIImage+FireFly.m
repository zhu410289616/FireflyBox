//
//  UIImage+FireFly.m
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "UIImage+FireFly.h"

#define DEGREES_2_RADIANS(x) (0.0174532925 * (x))

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

/**
 *  将一个UIImage 缩放变换到指定Size的UIImage
 *
 *  @param image image
 *  @param size  图片缩放到的大小
 *
 *  @return image
 */
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

/**
 *  合并图片，把merger image覆盖到原有图片上
 *
 *  @param mergerImage 覆盖图片
 *
 *  @return image
 */
- (UIImage *)imageWithMergerImage:(UIImage *)mergerImage
{
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [mergerImage drawInRect:CGRectMake(0, 0, mergerImage.size.width, mergerImage.size.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

/**
 *  制作图片遮罩
 *
 *  @param baseImage 需要是带alpha通道的图片
 *  @param maskImage 不带alpha通道的遮罩图
 *
 *  @return image
 */
+ (UIImage *)imageByMask:(UIImage *)tBaseImage maskImage:(UIImage *)tMaskImage
{
    UIGraphicsBeginImageContext(tBaseImage.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /**
     *  图片坐标系统原点在左上角，y方向向下的（坐标系A）
     *  但在Quartz中坐标系原点在左下角，y方向向上的(坐标系B)
     *  图片绘制也是颠倒的, 要达到预想的效果必须变换坐标系(注意下面的1，2)
     *  (可以使用UIImage drawInRect，替换该方法，实现想要的功能。)
     */
    CGRect area = CGRectMake(0, 0, tBaseImage.size.width, tBaseImage.size.height);
    CGContextScaleCTM(ctx, 1, -1);//1
    CGContextTranslateCTM(ctx, 0, -area.size.height);//2
    
    CGImageRef maskRef = tMaskImage.CGImage;
    CGImageRef maskImage = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                             CGImageGetHeight(maskRef),
                                             CGImageGetBitsPerComponent(maskRef),
                                             CGImageGetBitsPerPixel(maskRef),
                                             CGImageGetBytesPerRow(maskRef),
                                             CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef masked = CGImageCreateWithMask([tBaseImage CGImage], maskImage);
    CGImageRelease(maskImage);//释放内存
    CGContextDrawImage(ctx, area, masked);
    CGImageRelease(masked);//释放内存
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

/**
 *  带有alpha通道的圆盘图片
 *
 *  @param imageSize
 *  @param progress  value: [0-1]
 *
 *  @return uiimage
 */
+ (UIImage *)imageWithCircularProcess:(CGSize)imageSize progress:(float)progress
{
    float width = imageSize.width;
    float height = imageSize.height;
    UIGraphicsBeginImageContext(imageSize);
    
    CGPoint centerPoint = CGPointMake(height / 2, width / 2);
    CGFloat radius = MIN(height, width) / 2;
    
    CGFloat radians = DEGREES_2_RADIANS((progress*359.9)-90);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor redColor] setFill];
    CGMutablePathRef progressPath = CGPathCreateMutable();
    CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(270), radians, NO);
    CGPathCloseSubpath(progressPath);
    CGContextAddPath(context, progressPath);
    CGContextFillPath(context);
    CGPathRelease(progressPath);
    
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return pressedColorImg;
}

/**
 *  没有alpha通道的圆盘图片
 *
 *  @param imageSize imageSize description
 *  @param progress  value:[0-1]
 *
 *  @return uiimage
 */
+ (UIImage *)imageWithCircularProcessNoneAlpha:(CGSize)imageSize progress:(float)progress
{
    float width = imageSize.width;
    float height = imageSize.height;
    
    //圆心
    CGPoint centerPoint = CGPointMake(height / 2, width / 2);
    //半径
    CGFloat radius = MIN(height, width) / 2;
    //扇形开始角度
    CGFloat radians = DEGREES_2_RADIANS((360-progress*359.9)-270);
    
    //申请内存空间
    GLubyte * spriteData = (GLubyte *) calloc(width * height, sizeof(GLubyte));
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapContext = CGBitmapContextCreate(spriteData, width, height, 8, width, colorSpace, kCGImageAlphaNone);
    CGContextSetFillColorSpace(bitmapContext, colorSpace);
    
    //绘制全部底色
    CGRect rectAll = CGRectMake(0, 0, width, height);
    CGContextSetFillColorWithColor(bitmapContext, [UIColor blackColor].CGColor);
    CGContextFillRect(bitmapContext, rectAll);
    
    CGContextSetFillColorWithColor(bitmapContext, [UIColor whiteColor].CGColor);
    CGContextMoveToPoint(bitmapContext, centerPoint.x, centerPoint.y);
    CGContextAddArc(bitmapContext, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(90), radians, 0);
    CGContextClosePath(bitmapContext);
    CGContextFillPath(bitmapContext);
    
    //
    //    CGMutablePathRef progressPath = CGPathCreateMutable();
    //    CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
    //    CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(270), radians, NO);
    //    CGPathCloseSubpath(progressPath);
    //    CGContextAddPath(bitmapContext, progressPath);
    //    CGContextFillPath(bitmapContext);
    //    CGPathRelease(progressPath);
    //
    
    CGImageRef processImageRef = CGBitmapContextCreateImage(bitmapContext);
    UIImage *processImage = [UIImage imageWithCGImage:processImageRef];
    
    return processImage;
}

@end
