//
//  FFFileInfoCell.h
//  FireflyBox
//
//  Created by pig on 14-4-30.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFHeadImageCell.h"
#import "FFDataInfo.h"
#import "FFFileTypeIconView.h"

@interface FFFileInfoCell : FFHeadImageCell

@property (nonatomic, strong) FFFileTypeIconView *typeIconView;
@property (nonatomic, strong) UILabel *fileSizeLabel;

- (void)updateViewWithContent:(FFDataInfo *)tDataInfo;

@end
