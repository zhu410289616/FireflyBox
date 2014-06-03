//
//  FFGraffitiView.h
//  FireflyBox
//
//  Created by pig on 14-6-3.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  http://code.tutsplus.com/tutorials/ios-sdk_freehand-drawing--mobile-13164
 *
 *  涂鸦板
 */
@interface FFGraffitiView : UIView
{
    UIBezierPath *path;
    UIImage *incrementalImage;
    CGPoint pts[5]; // we now need to keep track of the four points of a Bezier segment and the first control point of the next segment
    uint ctr;
}

@end
