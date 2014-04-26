//
//  FFRecentCell.h
//  FireflyBox
//
//  Created by pig on 14-4-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFHeadImageCell.h"
#import "FFDataInfo.h"

@interface FFRecentCell : FFHeadImageCell

- (void)updateViewWithContent:(FFDataInfo *)tDataInfo;

@end
