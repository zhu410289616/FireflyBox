//
//  FFBaseTabBarController.m
//  FireflyBox
//
//  Created by pig on 14-4-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseTabBarController.h"

@interface FFBaseTabBarController ()

@end

@implementation FFBaseTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self hideRealTabBar];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideRealTabBar
{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
            view.hidden = YES;
            break;
        }
    }
}

@end
