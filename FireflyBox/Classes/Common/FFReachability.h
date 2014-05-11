//
//  FFReachability.h
//  FireflyBox
//
//  Created by pig on 14-5-11.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

#define DEFAULT_HOST_NAME @"www.baidu.com"

@class FFReachability;

typedef void(^ReachabilityBlock)(NetworkStatus netStatus, BOOL connectionRequired);

@interface FFReachability : NSObject

@property (nonatomic, strong) Reachability *hostReachability;
@property (nonatomic, strong) Reachability *internetReachability;
@property (nonatomic, strong) Reachability *wifiReachability;
@property (nonatomic, copy) ReachabilityBlock reachabilityBlock;

+ (id)sharedInstance;

- (id)initWithRemoteHostName:(NSString *)remoteHostName;
- (id)initWithDefaultHostName;

@end
