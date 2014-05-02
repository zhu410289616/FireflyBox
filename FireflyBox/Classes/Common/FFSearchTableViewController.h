//
//  FFSearchTableViewController.h
//  FireflyBox
//
//  Created by pig on 14-5-2.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFTableViewController.h"

@interface FFSearchTableViewController : FFTableViewController

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDC;

@property (nonatomic, strong) NSMutableArray *filterDataList;

- (void)searchFilter:(NSString *)keyword;

@end
