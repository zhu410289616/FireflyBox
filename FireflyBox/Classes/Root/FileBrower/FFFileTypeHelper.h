//
//  FFFileTypeHelper.h
//  FireflyBox
//
//  Created by pig on 14-5-1.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFDataInfo.h"

@interface FFFileTypeHelper : NSObject

@property (nonatomic, assign) UIViewController *viewController;
@property (nonatomic, strong) NSMutableArray *dataInfoList;
@property (nonatomic, strong) FFDataInfo *dataInfo;

- (void)doActionWithFileType;

@end
