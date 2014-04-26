//
//  FFDB+DataInfo.m
//  FireflyBox
//
//  Created by pig on 14-4-27.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFDB+DataInfo.h"

@implementation FFDB (DataInfo)

- (void)initDataInfo
{
    PLog(@"initDataInfo...");
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"create table if not exists FF_DATA_INFO (_id integer primary key autoincrement not null, dataid integer, parentdataid integer, datatype integer, dataname text, creationdate text, datapath text)"];
        [db open];
        [db executeUpdate:sql];
        [db close];
    }];
}

- (BOOL)insertDataInfo:(FFDataInfo *)tDataInfo
{
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        NSString *sql = @"insert into FF_DATA_INFO (dataid, parentdataid, datatype, dataname, creationdate, datapath) values (?, ?, ?, ?, ?, ?)";
        NSNumber *numDataId = [NSNumber numberWithLong:tDataInfo.dataId];
        NSNumber *numParentDataId = 0;
        NSNumber *numDataType = [NSNumber numberWithInt:tDataInfo.dataType];
        [db executeUpdate:sql, numDataId, numParentDataId, numDataType, tDataInfo.dataName, tDataInfo.creationDate, tDataInfo.dataPath];
        [db close];
    }];
    return YES;
}

- (NSMutableArray *)selectDataInfo
{
    __block NSMutableArray *dataInfoList = [[NSMutableArray alloc] init];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        NSString *sql = [NSString stringWithFormat:@"select * from FF_DATA_INFO order by _id"];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            FFDataInfo *dataInfo = [[FFDataInfo alloc] initWithFMResultSet:rs];
            [dataInfoList addObject:dataInfo];
        }
        [db close];
    }];
    return dataInfoList;
}

@end
