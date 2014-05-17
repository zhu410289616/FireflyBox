//
//  FFRootTabBarController.m
//  FireflyBox
//
//  Created by pig on 14-4-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFRootTabBarController.h"

#import "FFActionSheetView.h"
#import "FFNextStepViewController.h"
#import "FFAudioRecorderViewController.h"

#define TABBAR_HEIGHT 50.0f

@interface FFRootTabBarController ()

@end

@implementation FFRootTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _homeController = [[FFHomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:_homeController];
    _recentController = [[FFRecentViewController alloc] init];
    UINavigationController *recentNav = [[UINavigationController alloc] initWithRootViewController:_recentController];
    _settingController = [[FFSettingViewController alloc] init];
    UINavigationController *settingNav = [[UINavigationController alloc] initWithRootViewController:_settingController];
    _aboutController = [[FFAboutViewController alloc] init];
    UINavigationController *aboutNav = [[UINavigationController alloc] initWithRootViewController:_aboutController];
    
    int showContentType = 1;
    if (showContentType == 0) {
        self.viewControllers = [NSArray arrayWithObjects:homeNav, recentNav, settingNav, nil];
        NSArray *titleList = [NSArray arrayWithObjects:@"赤兔", @"工具", @"设置", nil];
        _tabBarView = [[FFTabBarView alloc] initWithFrame:CGRectMake(0, GLOBAL_SCREEN_HEIGHT - TABBAR_HEIGHT, GLOBAL_SCREEN_WIDTH, TABBAR_HEIGHT) titles:titleList];
        _tabBarView.delegate = self;
        _tabBarView.backgroundColor = [UIColor colorWithHex:0xc8c8c8];
        [self.view addSubview:_tabBarView];
    } else if (showContentType == 1) {
        self.viewControllers = [NSArray arrayWithObjects:homeNav, recentNav, aboutNav, nil];
        NSArray *titleList = [NSArray arrayWithObjects:@"赤兔", @"工具", @"关于", nil];
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

#pragma mark public function

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

#pragma mark private function

- (void)doShowTransferAction
{
    [[NSUserDefaults standardUserDefaults] setValue:@YES forKey:SHOULD_UPDATE_FILE_INFO];
    
    [_homeController doAddAction];
}

- (void)doShowNextStepAction
{
    FFNextStepViewController *nextStepController = [[FFNextStepViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:nextStepController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)doShowAudioRecorderAction
{
    [[NSUserDefaults standardUserDefaults] setValue:@YES forKey:SHOULD_UPDATE_FILE_INFO];
    
    FFAudioRecorderViewController *audioRecorderController = [[FFAudioRecorderViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:audioRecorderController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)doItemAction:(int)actionIndex
{
    PLog(@"doItemAction: %d", actionIndex);
    
    switch (actionIndex) {
        case 0:
            [self doShowTransferAction];
            break;
        case 1:
            [self doShowAudioRecorderAction];
            break;
        case 2:
            [self doShowNextStepAction];
            break;
            
        default:
            break;
    }
}

#pragma mark FFTabBarViewDelegate method

- (BOOL)tabBarItem:(FFTabBarItem *)tTabBarItem willSelected:(NSInteger)tIndex
{
    PLog(@"willSelected tIndex: %d", tIndex);
    
    if (tIndex == 1) {
        [_tabBarView selectedTabBarItem:self.selectedIndex];
        NSArray *titles = [NSArray arrayWithObjects:@"添加", @"录音", @"下一步", nil];
        FFActionSheetView *actionSheetView = [[FFActionSheetView alloc] initWithTitles:titles];
        actionSheetView.actionBlock = ^(int actionIndex) {
            [self doItemAction:actionIndex];
        };
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
