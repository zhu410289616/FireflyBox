//
//  FFFileViewController.h
//  FireflyBox
//
//  Created by pig on 14-4-30.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFTableViewController.h"
#import "EGORefreshTableHeaderView.h"

typedef enum {
    LoadFileInfoSourceDatabase = 1,
    LoadFileInfoSourceFileSystem,
    LoadFileInfoSourceUnknow
} LoadFileInfoSource;

@interface FFFileViewController : FFTableViewController<UISearchBarDelegate, UISearchDisplayDelegate, EGORefreshTableHeaderDelegate>

@property (nonatomic, assign) long parentDataId;
@property (nonatomic, strong) NSString *fileDir;
@property (nonatomic, strong) NSMutableArray *musicInfoList;

/*
 * refrush
 */
@property (nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, assign) BOOL isReloading;

/*
 * search
 */
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDC;
@property (nonatomic, strong) NSMutableArray *filterDataList;

- (void)loadFileInfo;
- (void)loadFileInfoWithParentDataId:(long)tParentDataId;
- (void)loadFileInfoWithDir:(NSString *)tDir parentDataId:(long)tParentDataId;
- (void)loadFileInfoFinished:(LoadFileInfoSource)tSource;

- (BOOL)shouldUpdateFileInfo;
- (void)searchFilter:(NSString *)keyword;

@end
