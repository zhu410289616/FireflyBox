//
//  FFDB.h
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"

@interface FFDB : NSObject

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

+ (id)sharedInstance;

- (NSString *)getSqliteFilePath;
- (void)initDatabase;

@end
