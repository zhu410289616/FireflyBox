//
//  FFDataInfo.h
//  FireflyBox
//
//  Created by pig on 14-4-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"

/*
 * 从磁盘获取数据大的分类, 需要写入数据库
 */
typedef enum {
    FFDataTypeUnknow = -1,
    FFDataTypeDirectory = 0,
    FFDataTypeRegular = 1
} FFDataType;

/*
 * 重新校对文件类型，用于判断跳转文件的打开方式
 * 不写入数据库，避免版本更新，打开方式增加而增加逻辑混乱
 */
typedef enum {
    FFFileTypeUnkown = -1,
    FFFileTypeDirectory = 0,
    FFFileTypeText = 1,
    FFFileTypePdf,
    FFFileTypeImage,
    FFFileTypeImageGif,
    FFFileTypeMusic,
    FFFileTypeVideo,
    FFFileTypeZip,
    FFFileTypeHtml,
    FFFileTypePlist
} FFFileType;

static int const TOP_PARENT_DATA_ID = 0;

@interface FFDataInfo : NSObject

@property (nonatomic, assign) long dataId;
@property (nonatomic, assign) long parentDataId;//上一层id，0为顶层目录
@property (nonatomic, assign) FFDataType dataType;//0-未知，1-目录，2-文件
@property (nonatomic, assign) FFFileType fileType;//具体的文件类型
@property (nonatomic, strong) UIColor *showColor;
@property (nonatomic, strong) NSString *dataName;
@property (nonatomic, strong) NSString *creationDate;
@property (nonatomic, strong) NSString *dataPath;
@property (nonatomic, assign) long lCreateTime;
@property (nonatomic, assign) long fileSize;

- (id)initWithFileAttributes:(NSDictionary *)fileAttributes name:(NSString *)name parentDataId:(long)tParentDataId;
- (id)initWithFMResultSet:(FMResultSet *)tResultSet;

@end
