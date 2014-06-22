//
//  FFReachability.m
//  FireflyBox
//
//  Created by pig on 14-5-11.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFReachability.h"

@implementation FFReachability

+ (id)sharedInstance
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithDefaultHostName];
    });
    return instance;
}

//

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

- (id)initWithRemoteHostName:(NSString *)remoteHostName
{
    if (self = [super init]) {
        /*
         Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the method reachabilityChanged will be called.
         */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        
        //
        self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
        [self.hostReachability startNotifier];
        [self updateInterfaceWithReachability:self.hostReachability];
        
        self.internetReachability = [Reachability reachabilityForInternetConnection];
        [self.internetReachability startNotifier];
        [self updateInterfaceWithReachability:self.internetReachability];
        
        self.wifiReachability = [Reachability reachabilityForLocalWiFi];
        [self.wifiReachability startNotifier];
        [self updateInterfaceWithReachability:self.wifiReachability];
        
    }
    return self;
}

- (id)initWithDefaultHostName
{
    return [self initWithRemoteHostName:DEFAULT_HOST_NAME];
}

/*!
 * Called by Reachability whenever status changes.
 */
- (void) reachabilityChanged:(NSNotification *)note
{
	Reachability *curReach = [note object];
	NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
	[self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    
    if (reachability == self.hostReachability)
	{
		[self updateInterfaceWithNetworkStatus:netStatus isConnectionRequired:connectionRequired];
    }
    
	if (reachability == self.internetReachability)
	{
		[self updateInterfaceWithNetworkStatus:netStatus isConnectionRequired:connectionRequired];
	}
    
	if (reachability == self.wifiReachability)
	{
		[self updateInterfaceWithNetworkStatus:netStatus isConnectionRequired:connectionRequired];
	}
}

- (void)updateInterfaceWithNetworkStatus:(NetworkStatus)netStatus isConnectionRequired:(BOOL)connectionRequired
{
    switch (netStatus) {
        case NotReachable:
            FFLOG_FORMAT(@"FFReachability: %@", @"Access Not Available");
            connectionRequired = NO;
            break;
        case ReachableViaWWAN:
            FFLOG_FORMAT(@"FFReachability: %@", @"Reachable WWAN");
            break;
        case ReachableViaWiFi:
            FFLOG_FORMAT(@"FFReachability: %@", @"Reachable WiFi");
            break;
            
        default:
            break;
    }
    
    if (connectionRequired) {
        FFLOG_FORMAT(@"FFReachability: %@", @"Cellular data network is available.\nInternet traffic will be routed through it after a connection is established.");
    } else {
        FFLOG_FORMAT(@"FFReachability: %@", @"Cellular data network is active.\nInternet traffic will be routed through it.");
    }
    
    if (_reachabilityBlock) {
        _reachabilityBlock(netStatus, connectionRequired);
    }
}

@end
