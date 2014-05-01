//
//  FFFileViewController.h
//  FireflyBox
//
//  Created by pig on 14-4-30.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFTableViewController.h"

@interface FFFileViewController : FFTableViewController

@property (nonatomic, strong) NSString *fileDir;
@property (nonatomic, strong) NSMutableArray *musicInfoList;

- (void)loadFileInfoWithDir:(NSString *)tDir;

@end
