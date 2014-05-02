//
//  FFHomeCell.h
//  FireflyBox
//
//  Created by pig on 14-4-25.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFHeadImageCell.h"
#import "FFDataInfo.h"
#import "FFFileTypeIconView.h"

@interface FFHomeCell : FFHeadImageCell

@property (nonatomic, strong) FFFileTypeIconView *typeIconView;

- (void)updateViewWithContent:(FFDataInfo *)tDataInfo;

@end
