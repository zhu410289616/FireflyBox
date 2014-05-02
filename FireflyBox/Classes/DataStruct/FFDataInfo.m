//
//  FFDataInfo.m
//  FireflyBox
//
//  Created by pig on 14-4-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFDataInfo.h"

@implementation FFDataInfo

- (id)initWithFileAttributes:(NSDictionary *)fileAttributes name:(NSString *)name
{
    if (self = [super init]) {
        for (NSString *str in fileAttributes) {
            PLog(@"%@ : %@", str, [fileAttributes objectForKey:str]);
        }
        long fileNumber = [[fileAttributes objectForKey:@"NSFileSystemFileNumber"] longValue];
        NSString *fileType = [fileAttributes objectForKey:@"NSFileType"];
        NSString *fileCreationDate = [fileAttributes objectForKey:@"NSFileCreationDate"];
        
        _dataName = name;
        _dataId = fileNumber;
        if ([fileType isEqualToString:NSFileTypeDirectory]) {
            _dataType = FFDataTypeDirectory;
            _fileType = FFFileTypeDirectory;
        } else if ([fileType isEqualToString:NSFileTypeRegular]) {
            _dataType = FFDataTypeRegular;
            [self getFileType:name];
        } else {
            _dataType = FFDataTypeUnknow;
            _fileType = FFFileTypeUnkown;
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

- (void)getFileType:(NSString *)tFilePath
{
    _fileType = FFFileTypeUnkown;
    _showColor = [UIColor blackColor];
    
    NSString *filePath = [tFilePath lowercaseString];
    if ([filePath hasSuffix:@".txt"]) {
        _fileType = FFFileTypeText;
        _showColor = [UIColor blueColor];
    } else if ([filePath hasSuffix:@".png"] || [filePath hasSuffix:@".jpg"]) {
        _fileType = FFFileTypeImage;
        _showColor = [UIColor purpleColor];
    } else if ([filePath hasSuffix:@".gif"]) {
        _fileType = FFFileTypeImageGif;
        _showColor = [UIColor lightGrayColor];
    } else if ([filePath hasSuffix:@".m4a"] || [filePath hasSuffix:@".mp3"] || [filePath hasSuffix:@".caf"]) {
        _fileType = FFFileTypeMusic;
        _showColor = [UIColor redColor];
    } else if ([filePath hasSuffix:@".mp4"]) {
        _fileType = FFFileTypeVideo;
        _showColor = [UIColor greenColor];
    }
}

@end
