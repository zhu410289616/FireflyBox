//
//  FFDB+Record.h
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFDB.h"
#import "Record.h"

@interface FFDB (Record)

- (void)initRecord;
- (BOOL)insertRecord:(Record *)tRecord;
- (NSMutableArray *)selectRecord;

@end
