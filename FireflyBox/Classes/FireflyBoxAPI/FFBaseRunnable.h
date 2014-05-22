//
//  FFBaseRunnable.h
//  FireflyBox
//
//  Created by pig on 14-5-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseSerializable.h"

@interface FFBaseRunnable : FFBaseObject<FFSerializableDelegate>

@property (nonatomic, weak) id<FFSerializableDelegate> delegate;

- (void) ajaxIn;
- (void) ajaxOut;
- (void) ajaxFail;

@end
