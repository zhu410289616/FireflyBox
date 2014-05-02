//
//  FFRootTabBarController.m
//  FireflyBox
//
//  Created by pig on 14-4-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFRootTabBarController.h"
#import "FFActionSheetView.h"

#define TABBAR_HEIGHT 50.0f

@interface FFRootTabBarController ()

@end

@implementation FFRootTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSArray *titleList = [NSArray arrayWithObjects:@"小盒子", @"萤火虫", @"设置", nil];
    _tabBarView = [[FFTabBarView alloc] initWithFrame:CGRectMake(0, GLOBAL_SCREEN_HEIGHT - TABBAR_HEIGHT, GLOBAL_SCREEN_WIDTH, TABBAR_HEIGHT) titles:titleList];
    _tabBarView.delegate = self;
    _tabBarView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_tabBarView];
    
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

- (void)tabBarItem:(FFTabBarItem *)tTabBarItem didSelected:(NSInteger)tIndex
{
    PLog(@"tIndex: %d", tIndex);
    
    if (tIndex == 1) {
        NSArray *titles = [NSArray arrayWithObjects:@"文字", @"拍照", nil];
        FFActionSheetView *actionSheetView = [[FFActionSheetView alloc] initWithTitles:titles];
        [actionSheetView showInView:self.view];
    } else {
        self.selectedIndex = tIndex;
    }
}

@end
