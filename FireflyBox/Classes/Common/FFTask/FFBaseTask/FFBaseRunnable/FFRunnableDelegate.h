//
//  FFRunnableDelegate.h
//  FireflyBox
//
//  Created by pig on 14-6-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FFRunnableDelegate <NSObject>

@required

- (void)ajaxIn:(id)aTask;
- (void)ajaxOut:(id)aTask;
- (void)ajaxFail:(id)aTask error:(NSError *)error;

@end
