//
//  FFTaskDelegate.h
//  FireflyBox
//
//  Created by pig on 14-6-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FFTaskDelegate <NSObject>

@optional

- (void)task:(id)aTask didFinishedWithResult:(id)result;
- (void)task:(id)aTask didFailedWithError:(NSError *)error;

@end
