//
//  FFGetSinaShowRoomListRunnable.m
//  FireflyBox
//
//  Created by pig on 14-6-22.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFGetSinaShowRoomListRunnable.h"

static NSString * const kSinaShowRoomListUrl = @"http://ok.sina.com.cn/ashx/getlist.ashx";

@implementation FFGetSinaShowRoomListRunnable

- (void)ajaxOut
{
    
}

- (NSString *)getHttpURL
{
    return [NSString stringWithFormat:@"%@", kSinaShowRoomListUrl];
}

@end
