//
//  FFDataInfo.m
//  FireflyBox
//
//  Created by pig on 14-4-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFDataInfo.h"

@implementation FFDataInfo

- (id)initWithFileAttributes:(NSDictionary *)fileAttributes
{
    if (self = [super init]) {
        for (NSString *str in fileAttributes) {
            PLog(@"%@ : %@", str, [fileAttributes objectForKey:str]);
        }
        long fileNumber = [[fileAttributes objectForKey:@"NSFileSystemFileNumber"] longValue];
        NSString *fileType = [fileAttributes objectForKey:@"NSFileType"];
        NSString *fileCreationDate = [fileAttributes objectForKey:@"NSFileCreationDate"];
        
        _dataId = fileNumber;
        if ([fileType isEqualToString:NSFileTypeDirectory]) {
            _dataType = FFDataTypeDirectory;
        } else if ([fileType isEqualToString:NSFileTypeRegular]) {
            _dataType = FFDataTypeRegular;
        } else {
            _dataType = FFDataTypeUnknow;
        }
        _creationDate = fileCreationDate;
    }
    return self;
}

- (id)initWithFMResultSet:(FMResultSet *)tResultSet
{
    if (self = [super init]) {
        _dataId = [tResultSet longForColumn:@"dataid"];//_id
        _parentDataId = [tResultSet longForColumn:@"parentdataid"];
        _dataType = [tResultSet intForColumn:@"datatype"];
        _dataName = [tResultSet stringForColumn:@"dataname"];
        _creationDate = [tResultSet stringForColumn:@"creationdate"];
        _dataPath = [tResultSet stringForColumn:@"datapath"];
    }
    return self;
}

- (void)log
{
    PLog(@"_dataId: %ld, _dataType: %d, _dataName: %@, _creationDate: %@, _dataPath: %@", _dataId, _dataType, _dataName, _creationDate, _dataPath);
}

@end
