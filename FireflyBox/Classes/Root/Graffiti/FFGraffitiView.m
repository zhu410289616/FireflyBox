//
//  FFGraffitiView.m
//  FireflyBox
//
//  Created by pig on 14-6-3.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFGraffitiView.h"

@implementation FFGraffitiView

- (id)init
{
    if (self = [super init]) {
        self.multipleTouchEnabled = NO;
        path = [UIBezierPath bezierPath];
        path.lineWidth = 2.0f;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [incrementalImage drawInRect:rect];
    [path stroke];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ctr = 0;
    UITouch *touch = [touches anyObject];
    pts[0] = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    ctr++;
    pts[ctr] = p;
    if (ctr == 4) {
        // move the endpoint to the middle of the line joining the second control point of the first Bezier segment and the first control point of the second Bezier segment
        pts[3] = CGPointMake((pts[2].x + pts[4].x)/2.0, (pts[2].y + pts[4].y)/2.0);
        
        [path moveToPoint:pts[0]];
        // add a cubic Bezier from pt[0] to pt[3], with control points pt[1] and pt[2]
        [path addCurveToPoint:pts[3] controlPoint1:pts[1] controlPoint2:pts[2]];
        
        [self setNeedsDisplay];
        
        // replace points and get ready to handle the next segment
        pts[0] = pts[3];
        pts[1] = pts[4];
        ctr = 1;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self drawBitmap];
    [self setNeedsDisplay];
    [path removeAllPoints];
    ctr = 0;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void)drawBitmap
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0f);
    if (!incrementalImage) {
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.bounds];
        [[UIColor whiteColor] setFill];
        [rectPath fill];
    }
    [incrementalImage drawAtPoint:CGPointZero];
    [[UIColor blackColor] setStroke];
    [path stroke];
    incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
