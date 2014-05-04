//
//  FFGetFileInfoTask.m
//  FireflyBox
//
//  Created by pig on 14-4-30.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFGetFileInfoTask.h"
#import "FFDataInfo.h"

@implementation FFGetFileInfoTask

- (id)init
{
    if (self = [super init]) {
        _fileInfoList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)executeTask
{
    PLog(@"_fileDir: %@", _fileDir);
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:_fileDir]) {
        NSError *error;
        NSArray *contents = [fm contentsOfDirectoryAtPath:_fileDir error:&error];
        for (id info in contents) {
            PLog(@"-------------- info: %@ --------------", info);
            NSString *infoPath = [NSString stringWithFormat:@"%@/%@", _fileDir, info];
            NSDictionary *fileAttributes = [fm attributesOfItemAtPath:infoPath error:&error];
            
            FFDataInfo *dataInfo = [[FFDataInfo alloc] initWithFileAttributes:fileAttributes name:info];
            dataInfo.dataPath = infoPath;
            
            [_fileInfoList addObject:dataInfo];
        }
        [_fileInfoList sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
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
}

@end
