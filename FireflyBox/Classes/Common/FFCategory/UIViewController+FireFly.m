//
//  UIViewController+FireFly.m
//  FireflyBox
//
//  Created by pig on 14-5-1.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "UIViewController+FireFly.h"

@implementation UIViewController (FireFly)

- (void)navigationWithCustomStyle:(NavigationStyle)navStyle toController:(UIViewController *)toController animated:(BOOL)animated
{
    switch (navStyle) {
        case NavigationStyleNormalPush:
        {
            [self.navigationController pushViewController:toController animated:animated];
        }
            break;
        case NavigationStylePopPush:
        {
            if ([self.navigationController.viewControllers containsObject:toController]) {
                [self.navigationController popToViewController:toController animated:animated];
            } else {
                [self.navigationController pushViewController:toController animated:animated];
            }
        }
            break;
        case NavigationStylePresent:
        {
            [self presentViewController:toController animated:animated completion:nil];
        }
            break;
        case NavigationStyleFlipHorizontal:
        {
            toController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [UIView animateWithDuration:0.5 animations:^{
                [self presentViewController:toController animated:NO completion:nil];
            }];
        }
            break;
            
        default:
            break;
    }
}

@end
