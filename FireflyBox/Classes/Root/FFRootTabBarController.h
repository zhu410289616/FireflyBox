//
//  FFRootTabBarController.h
//  FireflyBox
//
//  Created by pig on 14-4-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseTabBarController.h"
#import "FFTabBarView.h"
#import "FFHomeViewController.h"
#import "FFRecentViewController.h"
#import "FFSettingViewController.h"
#import "FFAboutViewController.h"

@interface FFRootTabBarController : FFBaseTabBarController<FFTabBarViewDelegate>

@property (nonatomic, strong) FFTabBarView *tabBarView;
@property (nonatomic, strong) FFHomeViewController *homeController;
@property (nonatomic, strong) FFRecentViewController *recentController;
@property (nonatomic, strong) FFSettingViewController *settingController;
@property (nonatomic, strong) FFAboutViewController *aboutController;

+ (id)sharedInstance;

- (void)hideFFTabBarView;
- (void)showFFTabBarView;

@end
