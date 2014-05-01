//
//  FFFileTypeHelper.h
//  FireflyBox
//
//  Created by pig on 14-5-1.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFDataInfo.h"

typedef enum {
    FFFileTypeUnkown = -1,
    FFFileTypeDirectory = 0,
    FFFileTypeText = 1,
    FFFileTypeImage,
    FFFileTypeImageGif,
    FFFileTypeMusic,
    FFFileTypeVideo
} FFFileType;

typedef void(^CheckFileTypeBlock)(FFFileType fileType);

@interface FFFileTypeHelper : NSObject

@property (nonatomic, assign) UIViewController *viewController;
@property (nonatomic, strong) FFDataInfo *dataInfo;
@property (nonatomic, copy) CheckFileTypeBlock fileTypeBlock;

- (void)doActionWithFileType;

@end
