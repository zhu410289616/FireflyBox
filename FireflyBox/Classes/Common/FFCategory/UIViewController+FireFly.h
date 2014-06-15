//
//  UIViewController+FireFly.h
//  FireflyBox
//
//  Created by pig on 14-5-1.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    NavigationStyleNormalPush,
    NavigationStylePopPush,
    NavigationStylePresent,
    NavigationStyleFlipHorizontal
} NavigationStyle;

@interface UIViewController (FireFly)

- (void)navigationWithCustomStyle:(NavigationStyle)navStyle toController:(UIViewController *)toController animated:(BOOL)animated;

@end
