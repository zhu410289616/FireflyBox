//
//  FFPageControl.m
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFPageControl.h"

@interface FFPageControl ()

- (void)updatePageIndex;

@end

@implementation FFPageControl

- (void)setNormalStateImage:(UIImage *)tNormalStateImage
{
    self.imagePageStateNormal = tNormalStateImage;
    [self updatePageIndex];
}

- (void)setHighlightedStateImage:(UIImage *)tHighlightedStateImage
{
    self.imagePageStateHighlighted = tHighlightedStateImage;
    [self updatePageIndex];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    [self updatePageIndex];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    [self updatePageIndex];
}

- (void)updatePageIndex
{
    if (self.imagePageStateNormal || self.imagePageStateHighlighted) {
        NSArray *subviews = self.subviews;
        int subviewcount = [subviews count];
        for (int i=0; i<subviewcount; i++) {
            id tempview = [subviews objectAtIndex:i];
            if ([tempview isKindOfClass:[UIImageView class]]) {
                UIImageView *dot = tempview;
                dot.image = (self.currentPage == i) ? self.imagePageStateHighlighted : self.imagePageStateNormal;
            }
        }//for
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
