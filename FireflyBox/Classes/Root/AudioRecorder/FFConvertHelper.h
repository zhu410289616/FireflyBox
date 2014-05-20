//
//  FFConvertHelper.h
//  FireflyBox
//
//  Created by pig on 14-5-20.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFConvertHelper : NSObject

+ (id)sharedInstance;

- (void)toMp3WithCafFilePath:(NSString *)tCafFilePath;

@end
