//
//  FFDataInfo.h
//  FireflyBox
//
//  Created by pig on 14-4-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"

typedef enum {
    FFDataTypeUnknow = 0,
    FFDataTypeDirectory = 1,
    FFDataTypeRegular = 2
} FFDataType;

@interface FFDataInfo : NSObject

@property (nonatomic, assign) long dataId;
@property (nonatomic, assign) long parentDataId;//上一层id，0为顶层目录
@property (nonatomic, assign) FFDataType dataType;//0-未知，1-目录，2-文件
@property (nonatomic, strong) NSString *dataName;
@property (nonatomic, strong) NSString *creationDate;
@property (nonatomic, strong) NSString *dataPath;
@property (nonatomic, assign) long lCreateTime;

- (id)initWithFileAttributes:(NSDictionary *)fileAttributes;
- (id)initWithFMResultSet:(FMResultSet *)tResultSet;
- (void)log;

@end
