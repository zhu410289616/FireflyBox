//
//  FFRootTabBarController.h
//  FireflyBox
//
//  Created by pig on 14-4-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseTabBarController.h"
#import "FFTabBarView.h"

@interface FFRootTabBarController : FFBaseTabBarController<FFTabBarViewDelegate>

@property (nonatomic, strong) FFTabBarView *tabBarView;

- (IBAction)doRightBarButtonItemAction:(id)sender;

- (void)hideFFTabBarView;
- (void)showFFTabBarView;

@end
