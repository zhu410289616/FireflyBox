//
//  FFDB+Record.m
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFDB+Record.h"

@implementation FFDB (Record)

- (void)initRecord
{
    PLog(@"initRecord...");
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"create table if not exists RUN_RECORD_DATA (_id integer primary key autoincrement not null, recordid integer, runnerid integer, onerunid integer, oldlatitude integer, oldlongitude integer, newlatitude integer, newlongitude integer, createtime integer)"];
        [db open];
        [db executeUpdate:sql];
        [db close];
    }];
}

- (BOOL)insertRecord:(Record *)tRecord
{
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        NSString *sql = @"insert into RUN_RECORD_DATA (recordid, runnerid, onerunid, oldlatitude, oldlongitude, newlatitude, newlongitude, createtime) values (?, ?, ?, ?, ?, ?, ?, ?)";
        NSNumber *numRecordId = [NSNumber numberWithLong:tRecord.recordId];
        NSNumber *numRunnerId = [NSNumber numberWithLong:tRecord.runnerId];
        NSNumber *numOneRunId = [NSNumber numberWithLong:tRecord.oneRunId];
        NSNumber *numOldLatitude = [NSNumber numberWithFloat:tRecord.oldLatitude];
        NSNumber *numOldLongitude = [NSNumber numberWithFloat:tRecord.oldLongitude];
        NSNumber *numNowLatitude = [NSNumber numberWithFloat:tRecord.nowLatitude];
        NSNumber *numNowLongitude = [NSNumber numberWithFloat:tRecord.nowLongitude];
        NSNumber *numCreateTime = [NSNumber numberWithLong:tRecord.createTime];
        [db executeUpdate:sql, numRecordId, numRunnerId, numOneRunId, numOldLatitude, numOldLongitude, numNowLatitude, numNowLongitude, numCreateTime];
        [db close];
    }];
    /*
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db open];
        NSString *sql = @"insert into RUN_RECORD_DATA (recordid, runnerid, onerunid, oldlatitude, oldlongitude, newlatitude, newlongitude, createtime) values (?, ?, ?, ?, ?, ?, ?, ?)";
        NSNumber *numRecordId = [NSNumber numberWithLong:tRecord.recordId];
        NSNumber *numRunnerId = [NSNumber numberWithLong:tRecord.runnerId];
        NSNumber *numOneRunId = [NSNumber numberWithLong:tRecord.oneRunId];
        NSNumber *numOldLatitude = [NSNumber numberWithFloat:tRecord.oldLatitude];
        NSNumber *numOldLongitude = [NSNumber numberWithFloat:tRecord.oldLongitude];
        NSNumber *numNowLatitude = [NSNumber numberWithFloat:tRecord.nowLatitude];
        NSNumber *numNowLongitude = [NSNumber numberWithFloat:tRecord.nowLongitude];
        NSNumber *numCreateTime = [NSNumber numberWithLong:tRecord.createTime];
        BOOL isDoSuccess = [db executeUpdate:sql, numRecordId, numRunnerId, numOneRunId, numOldLatitude, numOldLongitude, numNowLatitude, numNowLongitude, numCreateTime];
        if (!isDoSuccess) {
            *rollback = YES;
        }
        [db close];
    }];
    */
    return YES;
}

- (NSMutableArray *)selectRecord
{
    __block NSMutableArray *recordList = [[NSMutableArray alloc] init];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        NSString *sql = [NSString stringWithFormat:@"select * from RUN_RECORD_DATA order by _id"];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            Record *tempRecord = [[Record alloc] initWithFMResultSet:rs];
            [recordList addObject:tempRecord];
        }
        [db close];
    }];
    return recordList;
}

@end
