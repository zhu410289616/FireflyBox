//
//  FFDB.m
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFDB.h"

@implementation FFDB

+ (id)sharedInstance
{
    static id ffdbInstance = nil;
    static dispatch_once_t ffdbOnceToken;
    dispatch_once(&ffdbOnceToken, ^{
        ffdbInstance = [[FFDB alloc] init];
        [ffdbInstance initDatabase];
    });
    return ffdbInstance;
}

- (NSString *)getSqliteFilePath
{
    NSString *docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqliteFilePath = [docsdir stringByAppendingPathComponent:@"user.sqlite"];
    FFLog(@"sqliteFilePath: %@", sqliteFilePath);
    return sqliteFilePath;
}

- (void)initDatabase
{
    FFLog(@"initDatabase...");
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:[self getSqliteFilePath]];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSLog(@"%d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }];
    
}

@end
