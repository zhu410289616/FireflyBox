//
//  FFPhotoViewDelegate.h
//  FireflyBox
//
//  Created by pig on 14-6-10.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFPhotoView;
@class FFPhotoThumbnailView;

@protocol FFPhotoViewDelegate <NSObject>

@optional

/**
 *  FFPhotoView 放大缩小delegate
 */
- (void)photoViewDidSingleTap:(FFPhotoView *)photoView;
- (void)photoViewDidDoubleTap:(FFPhotoView *)photoView;
- (void)photoViewDidTwoFingerTap:(FFPhotoView *)photoView;
- (void)photoViewDidDoubleTwoFingerTap:(FFPhotoView *)photoView;

/**
 *  FFPhotoThumbnailView
 */
- (void)photoThumbnailViewDidSelect:(FFPhotoThumbnailView *)photoThumbnailView;
- (void)photoThumbnailViewDidDelete:(FFPhotoThumbnailView *)photoThumbnailView;

@end
