//
//  FFHomeViewController.h
//  FireflyBox
//
//  Created by pig on 14-4-20.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFTableViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface FFHomeViewController : FFTableViewController<UISearchBarDelegate, UISearchDisplayDelegate, EGORefreshTableHeaderDelegate>

@property (nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, assign) BOOL isReloading;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDC;

@property (nonatomic, strong) NSMutableArray *filterDataList;

- (void)doAddAction;

@end
