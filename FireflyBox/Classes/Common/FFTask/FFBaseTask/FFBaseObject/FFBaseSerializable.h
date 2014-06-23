//
//  FFBaseSerializable.h
//  FireflyBox
//
//  Created by pig on 14-6-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseObject.h"
#import "FFSerializableDelegate.h"

@interface FFBaseSerializable : FFBaseObject<FFSerializableDelegate>

- (NSArray *)fields;

@end
