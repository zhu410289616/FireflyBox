//
//  FFHomeViewController.h
//  FireflyBox
//
//  Created by pig on 14-4-20.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFTableViewController.h"
#import "FFEmptyTipsView.h"

@interface FFHomeViewController : FFTableViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UIView *typeBarView;
@property (nonatomic, strong) UIButton *firstTypeButton;
@property (nonatomic, strong) UIButton *secondTypeButton;
@property (nonatomic, strong) UIButton *thirdTypeButton;

@property (nonatomic, strong) FFEmptyTipsView *emptyTipsView;

- (void)loadData;

@end
