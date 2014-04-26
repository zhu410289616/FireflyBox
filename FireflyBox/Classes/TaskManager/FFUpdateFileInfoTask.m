//
//  FFUpdateFileInfoTask.m
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFUpdateFileInfoTask.h"
#import "FFDataInfo.h"
#import "FFDB+All.h"

@implementation FFUpdateFileInfoTask

- (id)init
{
    if (self = [super init]) {
        _dataInfoList = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark implement method

- (void)executeTask
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *webServerPath = [NSString stringWithFormat:@"%@%@", documentsPath, TRANSFER_WEB_SERVER_DIR];
    PLog(@"webServerPath: %@", webServerPath);
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:webServerPath]) {
        NSDirectoryEnumerator *dirEnum = [fm enumeratorAtPath:webServerPath];
        for (id info in dirEnum) {
            PLog(@"-------------- info: %@ --------------", info);
            NSError *error;
            NSString *infoPath = [NSString stringWithFormat:@"%@/%@", webServerPath, info];
            NSDictionary *fileAttributes = [fm attributesOfItemAtPath:infoPath error:&error];
            
            FFDataInfo *dataInfo = [[FFDataInfo alloc] initWithFileAttributes:fileAttributes];
            dataInfo.dataName = info;
            dataInfo.dataPath = infoPath;
            
            [[FFDB sharedInstance] insertDataInfo:dataInfo];
            
            [_dataInfoList addObject:dataInfo];
        }
    } else {
        [fm createDirectoryAtPath:webServerPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

@end
