//
//  FFSerialQueue.h
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseQueue.h"

@interface FFSerialQueue : FFBaseQueue
{
    dispatch_queue_t _serialQueue;
}

+ (id)sharedInstance;

@end
