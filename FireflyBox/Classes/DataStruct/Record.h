//
//  Record.h
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"

@interface Record : NSObject

@property (nonatomic, assign) long recordId;//该条记录id
@property (nonatomic, assign) long runnerId;//用户id
@property (nonatomic, assign) long oneRunId;//本次跑步id

@property (nonatomic, assign) float oldLatitude;
@property (nonatomic, assign) float oldLongitude;
@property (nonatomic, assign) float nowLatitude;
@property (nonatomic, assign) float nowLongitude;
@property (nonatomic, assign) long createTime;

- (id)initWithFMResultSet:(FMResultSet *)tResultSet;

@end
