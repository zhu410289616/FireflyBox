//
//  FFRootTabBarController.m
//  FireflyBox
//
//  Created by pig on 14-4-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFRootTabBarController.h"
#import "FFHomeViewController.h"
#import "FFRecentViewController.h"
#import "FFSettingViewController.h"
#import "FFAboutViewController.h"

#import "FFActionSheetView.h"

#define TABBAR_HEIGHT 50.0f

@interface FFRootTabBarController ()

@end

@implementation FFRootTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    FFHomeViewController *homeController = [[FFHomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeController];
    FFRecentViewController *recentController = [[FFRecentViewController alloc] init];
    UINavigationController *recentNav = [[UINavigationController alloc] initWithRootViewController:recentController];
    FFSettingViewController *settingController = [[FFSettingViewController alloc] init];
    UINavigationController *settingNav = [[UINavigationController alloc] initWithRootViewController:settingController];
    FFAboutViewController *aboutController = [[FFAboutViewController alloc] init];
    UINavigationController *aboutNav = [[UINavigationController alloc] initWithRootViewController:aboutController];
    
    int showContentType = 1;
    if (showContentType == 0) {
        self.viewControllers = [NSArray arrayWithObjects:homeNav, recentNav, settingNav, nil];
        NSArray *titleList = [NSArray arrayWithObjects:@"小盒子", @"工具", @"设置", nil];
        _tabBarView = [[FFTabBarView alloc] initWithFrame:CGRectMake(0, GLOBAL_SCREEN_HEIGHT - TABBAR_HEIGHT, GLOBAL_SCREEN_WIDTH, TABBAR_HEIGHT) titles:titleList];
        _tabBarView.delegate = self;
        _tabBarView.backgroundColor = [UIColor colorWithHex:0xc8c8c8];
        [self.view addSubview:_tabBarView];
    } else if (showContentType == 1) {
        self.viewControllers = [NSArray arrayWithObjects:homeNav, recentNav, aboutNav, nil];
        NSArray *titleList = [NSArray arrayWithObjects:@"小盒子", @"工具", @"关于", nil];
        _tabBarView = [[FFTabBarView alloc] initWithFrame:CGRectMake(0, GLOBAL_SCREEN_HEIGHT - TABBAR_HEIGHT, GLOBAL_SCREEN_WIDTH, TABBAR_HEIGHT) titles:titleList];
        _tabBarView.delegate = self;
        _tabBarView.backgroundColor = [UIColor colorWithHex:0xc8c8c8];
        [self.view addSubview:_tabBarView];
    }
    
    
    [_tabBarView selectedTabBarItem:0];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideFFTabBarView
{
    [UIView animateWithDuration:0.3 animations:^{
        _tabBarView.frame = CGRectMake(0, GLOBAL_SCREEN_HEIGHT, GLOBAL_SCREEN_WIDTH, TABBAR_HEIGHT);
    } completion:^(BOOL finished) {
        _tabBarView.hidden = YES;
    }];
}

- (void)showFFTabBarView
{
    _tabBarView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _tabBarView.frame = CGRectMake(0, GLOBAL_SCREEN_HEIGHT - TABBAR_HEIGHT, GLOBAL_SCREEN_WIDTH, TABBAR_HEIGHT);
    } completion:^(BOOL finished) {
        _tabBarView.hidden = NO;
    }];
}

#pragma mark FFTabBarViewDelegate method

- (BOOL)tabBarItem:(FFTabBarItem *)tTabBarItem willSelected:(NSInteger)tIndex
{
    PLog(@"willSelected tIndex: %d", tIndex);
    
    if (tIndex == 1) {
        [_tabBarView selectedTabBarItem:self.selectedIndex];
        NSArray *titles = [NSArray arrayWithObjects:@"文字", @"拍照", nil];
        FFActionSheetView *actionSheetView = [[FFActionSheetView alloc] initWithTitles:titles];
        [actionSheetView showInView:self.view];
        return NO;
    }
    return YES;
}

- (void)tabBarItem:(FFTabBarItem *)tTabBarItem didSelected:(NSInteger)tIndex
{
    PLog(@"didSelected tIndex: %d", tIndex);
    self.selectedIndex = tIndex;
}

@end
