//
//  FFGetFileInfoTask.h
//  FireflyBox
//
//  Created by pig on 14-4-30.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBoxTask.h"

@interface FFGetFileInfoTask : FFBoxTask

@property (nonatomic, assign) long parentDataId;
@property (nonatomic, strong) NSString *fileDir;
@property (nonatomic, strong) NSMutableArray *fileInfoList;

@end
