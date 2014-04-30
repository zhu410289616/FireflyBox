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
            
            FFDataInfo *dataInfo = [[FFDataInfo alloc] initWithFileAttributes:fileAttributes];
            dataInfo.dataName = info;
            dataInfo.dataPath = infoPath;
            
            [_fileInfoList addObject:dataInfo];
        }
    }
}

@end
