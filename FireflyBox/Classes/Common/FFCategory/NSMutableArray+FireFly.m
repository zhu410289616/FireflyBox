//
//  NSMutableArray+FireFly.m
//  FireflyBox
//
//  Created by pig on 14-5-10.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "NSMutableArray+FireFly.h"
#import "FFDataInfo.h"

@implementation NSMutableArray (FireFly)

- (void)sortDataInfoList
{
    [self sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        FFDataInfo *info1 = obj1;
        FFDataInfo *info2 = obj2;
        if ([info1.dataName compare:info2.dataName options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            if (info1.lCreateTime > info2.lCreateTime) {
                return NSOrderedAscending;
            } else if (info1.lCreateTime < info2.lCreateTime) {
                return NSOrderedDescending;
            } else {
                return NSOrderedSame;
            }
        }
        return [info1.dataName compare:info2.dataName options:NSCaseInsensitiveSearch];
    }];
}

@end
