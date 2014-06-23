//
//  FFBaseRunnable.h
//  FireflyBox
//
//  Created by pig on 14-5-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseSerializable.h"
#import "FFRunnableDelegate.h"

typedef enum {
    FFRunnbaleErrorCodeNormal = 0,
    FFRunnbaleErrorCodeUnkown
} FFRunnbaleErrorCode;

@interface FFBaseRunnable : FFBaseSerializable<FFRunnableDelegate>

/**
 *  param [out]
 */
@property (nonatomic, strong) NSDictionary *dicResult;
@property (nonatomic, assign) NSError *error;

@end
