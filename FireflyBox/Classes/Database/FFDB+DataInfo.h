//
//  FFDB+DataInfo.h
//  FireflyBox
//
//  Created by pig on 14-4-27.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFDB.h"
#import "FFDataInfo.h"

@interface FFDB (DataInfo)

- (void)initDataInfo;
- (BOOL)insertDataInfo:(FFDataInfo *)tDataInfo;
- (NSMutableArray *)selectDataInfo;
- (NSMutableArray *)selectDataInfoWithDataId:(long)tDataId;
- (NSMutableArray *)selectDataInfoWithParentDataId:(long)tParentDataId;

@end
