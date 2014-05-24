//
//  FFConcurrentQueue.h
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseQueue.h"

@interface FFConcurrentQueue : FFBaseQueue

+ (id)sharedInstance;

@end
