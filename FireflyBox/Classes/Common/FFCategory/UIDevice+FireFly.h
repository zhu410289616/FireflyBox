//
//  UIDevice+FireFly.h
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (FireFly)

@property (nonatomic, assign, readonly) BOOL isRetinaScreen;
@property (nonatomic, assign, readonly) float screenScale;

@end
