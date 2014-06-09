//
//  FFPhotoView.h
//  FireflyBox
//
//  Created by pig on 14-6-9.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFPhotoView;

@protocol FFPhotoViewDelegate <NSObject>

@optional

- (void)photoViewDidSingleTap:(FFPhotoView *)photoView;
- (void)photoViewDidDoubleTap:(FFPhotoView *)photoView;
- (void)photoViewDidTwoFingerTap:(FFPhotoView *)photoView;
- (void)photoViewDidDoubleTwoFingerTap:(FFPhotoView *)photoView;

@end

@interface FFPhotoView : UIScrollView

@property (nonatomic, weak) id<FFPhotoViewDelegate> photoViewDelegate;

- (void)prepareForReuse;
- (void)displayImage:(UIImage *)image;

- (void)startWaiting;
- (void)stopWaiting;

- (void)updateZoomScale:(CGFloat)newScale;
- (void)updateZoomScale:(CGFloat)newScale withCenter:(CGPoint)center;

@end
