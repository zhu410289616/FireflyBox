//
//  FFTableViewController.h
//  FireflyBox
//
//  Created by pig on 14-4-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseViewController.h"
#import "FFEmptyTipsView.h"

@interface FFTableViewController : FFBaseViewController

@property (nonatomic, strong) UITableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) FFEmptyTipsView *emptyTipsView;

- (void)showOrHideEmptyTips;

@end
