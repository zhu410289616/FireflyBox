//
//  Record.m
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "Record.h"

@implementation Record

- (id)initWithFMResultSet:(FMResultSet *)tResultSet
{
    if (self = [super init]) {
        _recordId = [tResultSet longForColumn:@"recordid"];//_id
        _runnerId = [tResultSet longForColumn:@"runnerid"];
        _oneRunId = [tResultSet longForColumn:@"onerunid"];
        
        _oldLatitude = [tResultSet doubleForColumn:@"oldlatitude"];
        _oldLongitude = [tResultSet doubleForColumn:@"oldlongitude"];
        _nowLatitude = [tResultSet doubleForColumn:@"newlatitude"];
        _nowLongitude = [tResultSet doubleForColumn:@"newlongitude"];
        _createTime = [tResultSet longForColumn:@"createtime"];
    }
    return self;
}

@end
