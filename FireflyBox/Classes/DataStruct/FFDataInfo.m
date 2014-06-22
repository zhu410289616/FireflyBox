//
//  FFDataInfo.m
//  FireflyBox
//
//  Created by pig on 14-4-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFDataInfo.h"

@implementation FFDataInfo

- (id)initWithFileAttributes:(NSDictionary *)fileAttributes name:(NSString *)name parentDataId:(long)tParentDataId
{
    if (self = [super init]) {
        for (NSString *str in fileAttributes) {
            FFLog(@"%@ : %@", str, [fileAttributes objectForKey:str]);
        }
        long fileNumber = [[fileAttributes objectForKey:@"NSFileSystemFileNumber"] longValue];
        NSString *fileType = [fileAttributes objectForKey:@"NSFileType"];
        NSDate *fileCreationDate = [fileAttributes objectForKey:@"NSFileCreationDate"];
        
        _fileSize = [[fileAttributes objectForKey:@"NSFileSize"] longValue];
        _dataName = name;
        _dataId = fileNumber;
        _parentDataId = tParentDataId;
        if ([fileType isEqualToString:NSFileTypeDirectory]) {
            _dataType = FFDataTypeDirectory;
            _fileType = FFFileTypeDirectory;
            _showColor = [UIColor colorWithHex:0x157dfb];
        } else if ([fileType isEqualToString:NSFileTypeRegular]) {
            _dataType = FFDataTypeRegular;
            [self getFileTypeWithFileName:name];
        } else {
            _dataType = FFDataTypeUnknow;
            _fileType = FFFileTypeUnkown;
            _showColor = [UIColor colorWithHex:0x157dfb];
        }
        _creationDate = [NSString stringWithDate:fileCreationDate formatter:@"yyyy-MM-dd HH:mm:ss"];
        _lCreateTime = [fileCreationDate timeIntervalSince1970];
    }
    return self;
}

- (id)initWithFMResultSet:(FMResultSet *)tResultSet
{
    if (self = [super init]) {
        _dataId = [tResultSet longForColumn:@"dataid"];//_id
        _parentDataId = [tResultSet longForColumn:@"parentdataid"];
        _dataType = [tResultSet intForColumn:@"datatype"];
        _fileType = [tResultSet intForColumn:@"filetype"];
        _dataName = [tResultSet stringForColumn:@"dataname"];
        _creationDate = [tResultSet stringForColumn:@"creationdate"];
        _dataPath = [tResultSet stringForColumn:@"datapath"];
        _fileSize = [tResultSet longForColumn:@"filesize"];
        [self getShowColorWithFileType:_fileType];
    }
    return self;
}

- (void)getShowColorWithFileType:(FFFileType)tFileType
{
    _showColor = [UIColor colorWithHex:0x157dfb];
    
    FFFileType type = tFileType;
    switch (type) {
        case FFFileTypeDirectory:
            _showColor = [UIColor colorWithHex:0x157dfb];
            break;
        case FFFileTypeText:
            _showColor = [UIColor colorWithHex:0xdeb887];
            break;
        case FFFileTypePdf:
            _showColor = [UIColor redColor];
            break;
        case FFFileTypeImage:
            _showColor = [UIColor greenColor];
            break;
        case FFFileTypeImageGif:
            _showColor = [UIColor blueColor];
            break;
        case FFFileTypeMusic:
            _showColor = [UIColor magentaColor];
            break;
        case FFFileTypePlist:
            _showColor = [UIColor colorWithHex:0x228b22];
            break;
        case FFFileTypeZip:
            _showColor = [UIColor orangeColor];
            break;
        case FFFileTypeHtml:
            _showColor = [UIColor purpleColor];
            break;
        case FFFileTypeVideo:
            _showColor = [UIColor brownColor];
            break;
            
        default:
            break;
    }
}

- (void)getFileTypeWithFileName:(NSString *)tFileName
{
    _fileType = FFFileTypeUnkown;
    _showColor = [UIColor colorWithHex:0x157dfb];
    
    NSString *name = [[tFileName lowercaseString] pathExtension];
    if ([name hasSuffix:@"txt"] || [name hasSuffix:@"rtf"]) {
        _fileType = FFFileTypeText;
        _showColor = [UIColor colorWithHex:0xdeb887];
    } else if ([name hasPrefix:@"pdf"]) {
        _fileType = FFFileTypePdf;
        _showColor = [UIColor redColor];
    } else if ([name hasSuffix:@"png"] || [name hasSuffix:@"jpg"]) {
        _fileType = FFFileTypeImage;
        _showColor = [UIColor greenColor];
    } else if ([name hasSuffix:@"gif"]) {
        _fileType = FFFileTypeImageGif;
        _showColor = [UIColor blueColor];
    } else if ([name hasSuffix:@"m4a"] || [name hasSuffix:@"mp3"] || [name hasSuffix:@"caf"] || [name hasSuffix:@"aac"]) {
        _fileType = FFFileTypeMusic;
        _showColor = [UIColor magentaColor];
    } else if ([name hasSuffix:@"plist"]) {
        _fileType = FFFileTypePlist;
        _showColor = [UIColor colorWithHex:0x228b22];
    } else if ([name hasPrefix:@"zip"] || [name hasPrefix:@"rar"]) {
        _fileType = FFFileTypeZip;
        _showColor = [UIColor orangeColor];
    } else if ([name hasPrefix:@"html"] || [name hasPrefix:@"htm"]) {
        _fileType = FFFileTypeHtml;
        _showColor = [UIColor purpleColor];
    } else if ([name hasPrefix:@"mp4"]) {
        _fileType = FFFileTypeVideo;
        _showColor = [UIColor brownColor];
    }
}

@end
