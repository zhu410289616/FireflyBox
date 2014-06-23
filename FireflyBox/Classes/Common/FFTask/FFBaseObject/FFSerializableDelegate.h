//
//  FFSerializableDelegate.h
//  FireflyBox
//
//  Created by pig on 14-6-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FFSerializableDelegate <NSObject>

- (BOOL)deserialize:(NSString *)str;
- (BOOL)deserialize:(NSString *)str startFrom:(int)offset;

- (NSString *)serialize;

@end
