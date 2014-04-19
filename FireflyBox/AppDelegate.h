//
//  AppDelegate.h
//  FireflyBox
//
//  Created by pig on 14-4-19.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFHomeViewController.h"
#import "FFAppLoader.h"
#import "HTTPServer.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) FFHomeViewController *homeController;
@property (nonatomic, strong) UINavigationController *navController;

@property (nonatomic, strong) HTTPServer *httpServer;

@end
