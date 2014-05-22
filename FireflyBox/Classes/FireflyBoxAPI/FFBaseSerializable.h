//
//  FFBaseSerializable.h
//  FireflyBox
//
//  Created by pig on 14-5-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseObject.h"

@interface FFBaseSerializable : FFBaseObject

- (BOOL)deserialize:(NSString *)str;
- (BOOL)deserialize:(NSString *)str startFrom:(int)offset;

- (NSString *)serialize;

@end
