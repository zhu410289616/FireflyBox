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

typedef enum {
    ToolItemActionTypeNextStep = 0,
    ToolItemActionTypeTransfer,
    ToolItemActionTypeAudioRecorder,
    ToolItemActionTypeCamera,
    ToolItemActionTypeGif,
    ToolItemActionTypeBluetooth,
    ToolItemActionTypeGraffiti,
    ToolItemActionTypeTest,
    ToolItemActionTypeUnkown
} ToolItemActionType;

@interface FFRootTabBarController : FFBaseTabBarController<FFTabBarViewDelegate>

@property (nonatomic, strong) FFTabBarView *tabBarView;
@property (nonatomic, strong) FFHomeViewController *homeController;
@property (nonatomic, strong) FFRecentViewController *recentController;
@property (nonatomic, strong) FFSettingViewController *settingController;

+ (id)sharedInstance;

- (void)hideFFTabBarView;
- (void)showFFTabBarView;

@end
