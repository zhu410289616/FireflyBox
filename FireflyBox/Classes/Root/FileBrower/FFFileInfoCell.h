//
//  FFFileInfoCell.h
//  FireflyBox
//
//  Created by pig on 14-4-30.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFHeadImageCell.h"
#import "FFDataInfo.h"

@interface FFFileInfoCell : FFHeadImageCell

- (void)updateViewWithContent:(FFDataInfo *)tDataInfo;

@end
