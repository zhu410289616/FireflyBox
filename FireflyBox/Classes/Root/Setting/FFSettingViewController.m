//
//  FFSettingViewController.m
//  FireflyBox
//
//  Created by pig on 14-4-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFSettingViewController.h"
#import "FFSettingCell.h"
#import "FFAboutViewController.h"

@interface FFSettingViewController ()

@end

@implementation FFSettingViewController

- (id)init
{
    if (self = [super init]) {
        self.title = @"设置";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.dataTableView.delegate = self;
    [self.view addSubview:self.dataTableView];
    
    UIView *tableHeaderView = [[UIView alloc] init];
    tableHeaderView.frame = CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, 40);
    self.dataTableView.tableHeaderView = tableHeaderView;
    
    NSArray *settingMenu = [NSArray arrayWithObjects:@"吐个槽", @"关于", nil];
    static NSString *CellIdentifier = @"FFSettingCell";
    
    FFTableViewCellConfigureBlock configureCell = ^(FFSettingCell *cell, id item, NSIndexPath *indexPath) {
        [cell configureCellWithItem:item indexPath:indexPath];
    };
    self.itemsDataSource = [[FFTableViewDataSource alloc] initWithItems:settingMenu cellIdentifier:CellIdentifier configureCellBlock:configureCell];
    self.dataTableView.dataSource = self.itemsDataSource;
    [self.dataTableView registerClass:[FFSettingCell class] forCellReuseIdentifier:CellIdentifier];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [GLOBAL_APP_DELEGATE.tabBarController showFFTabBarView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    [GLOBAL_APP_DELEGATE.tabBarController hideFFTabBarView];
    
    switch (indexPath.row) {
        case 0:
        {
            NSString *str = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", @"874328260"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
        case 1:
        {
            FFAboutViewController *aboutController = [[FFAboutViewController alloc] init];
            [self navigationWithCustomStyle:NavigationStylePopPush toController:aboutController animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

@end
