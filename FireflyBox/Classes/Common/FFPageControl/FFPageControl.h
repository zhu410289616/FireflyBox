//
//  FFPageControl.h
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFPageControl : UIPageControl

@property (nonatomic, strong) UIImage *imagePageStateNormal;
@property (nonatomic, strong) UIImage *imagePageStateHighlighted;

- (void)setNormalStateImage:(UIImage *)tNormalStateImage;
- (void)setHighlightedStateImage:(UIImage *)tHighlightedStateImage;

@end
