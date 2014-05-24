//
//  FFBaseRunnable.h
//  FireflyBox
//
//  Created by pig on 14-5-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseSerializable.h"

@interface FFBaseRunnable : FFBaseSerializable

#pragma mark param out

@property (nonatomic, strong) NSDictionary *dicResult;
@property (nonatomic, assign) NSError *error;

/**
 *  task具体参数逻辑
 */
- (void)ajaxIn;
- (void)ajaxOut;
- (void)ajaxFail;

@end
