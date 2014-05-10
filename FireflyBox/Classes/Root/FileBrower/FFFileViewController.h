//
//  FFFileViewController.h
//  FireflyBox
//
//  Created by pig on 14-4-30.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFTableViewController.h"

@interface FFFileViewController : FFTableViewController<UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, assign) long parentDataId;
@property (nonatomic, strong) NSString *fileDir;
@property (nonatomic, strong) NSMutableArray *musicInfoList;

/*
 * search
 */
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDC;
@property (nonatomic, strong) NSMutableArray *filterDataList;

@end
