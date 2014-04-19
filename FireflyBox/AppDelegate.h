//
//  AppDelegate.h
//  FireflyBox
//
//  Created by pig on 14-4-19.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPServer.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) HTTPServer *httpServer;

@end
