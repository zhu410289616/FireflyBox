//
//  FFTableViewController.m
//  FireflyBox
//
//  Created by pig on 14-4-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFTableViewController.h"
#import "FFTableViewCell.h"

static NSString * const FFTableViewCellIdentifier = @"FFTableViewCellIdentifier";

@interface FFTableViewController ()

@end

@implementation FFTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.dataTableView = [[UITableView alloc] init];
    self.dataTableView.frame = CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, GLOBAL_SCREEN_HEIGHT);
    self.dataTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataTableView.backgroundColor = [UIColor colorWithHex:0xe5e5e5];
    [self.view addSubview:self.dataTableView];
    
    FFTableViewCellConfigureBlock configureCell = ^(FFTableViewCell *cell, id item) {
        [cell configureCellWithItem:item];
    };
    self.itemsDataSource = [[FFTableViewDataSource alloc] initWithItems:nil cellIdentifier:FFTableViewCellIdentifier configureCellBlock:configureCell];
    self.dataTableView.dataSource = self.itemsDataSource;
    [self.dataTableView registerClass:[FFTableViewCell class] forCellReuseIdentifier:FFTableViewCellIdentifier];
    
    self.dataList = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * override in sub class
 */
- (void)showOrHideEmptyTips
{
    FFLog(@"showOrHideEmptyTips...");
}

#pragma mark UITableViewDataSource method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark UITableViewDelegate method
//

@end
