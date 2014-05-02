//
//  FFHomeViewController.h
//  FireflyBox
//
//  Created by pig on 14-4-20.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFTableViewController.h"

@interface FFHomeViewController : FFTableViewController<UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDC;

@property (nonatomic, strong) NSMutableArray *filterDataList;

- (void)loadFileInfoInHome;
- (void)loadFileInfoWithDir:(NSString *)tDir;
- (void)searchFilter:(NSString *)keyword;

@end
