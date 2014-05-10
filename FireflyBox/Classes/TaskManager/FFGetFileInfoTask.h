//
//  FFGetFileInfoTask.h
//  FireflyBox
//
//  Created by pig on 14-4-30.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseTask.h"

@interface FFGetFileInfoTask : FFBaseTask

@property (nonatomic, assign) long parentDataId;
@property (nonatomic, strong) NSString *fileDir;
@property (nonatomic, strong) NSMutableArray *fileInfoList;

@end
