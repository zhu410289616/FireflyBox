//
//  FFRootTabBarController.m
//  FireflyBox
//
//  Created by pig on 14-4-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFRootTabBarController.h"
#import "FFBarButtonItem.h"

#define TABBAR_HEIGHT 50.0f

@interface FFRootTabBarController ()

@end

@implementation FFRootTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    FFBarButtonItem *tempBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = tempBarButtonItem;
    
    NSArray *titleList = [NSArray arrayWithObjects:@"TabBarItem1", @"TabBarItem2", @"TabBarItem3", nil];
    FFTabBarView *tabBarView = [[FFTabBarView alloc] initWithFrame:CGRectMake(0, GLOBAL_SCREEN_HEIGHT - TABBAR_HEIGHT, GLOBAL_SCREEN_WIDTH, TABBAR_HEIGHT) titles:titleList];
    tabBarView.delegate = self;
    tabBarView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:tabBarView];
    
    [tabBarView selectedTabBarItem:0];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

- (IBAction)doRightBarButtonItemAction:(id)sender
{
    PLog(@"doRightBarButtonItemAction...");
}

#pragma mark FFTabBarViewDelegate method

- (void)tabBarItem:(FFTabBarItem *)tTabBarItem didSelected:(NSInteger)tIndex
{
    self.selectedIndex = tIndex;
    PLog(@"tIndex: %ld", tIndex);
}

- (void)hideFFTabBarView
{
    for (UIView *view in self.view.subviews) {
        if([view isKindOfClass:[FFTabBarView class]]){
            [UIView animateWithDuration:0.6 animations:^{
                view.frame = CGRectMake(0, GLOBAL_SCREEN_HEIGHT, GLOBAL_SCREEN_WIDTH, TABBAR_HEIGHT);
            } completion:^(BOOL finished) {
                view.hidden = YES;
            }];
            break;
        }
    }
}

- (void)showFFTabBarView
{
    for (UIView *view in self.view.subviews) {
        if([view isKindOfClass:[FFTabBarView class]]){
            [UIView animateWithDuration:0.6 animations:^{
                view.frame = CGRectMake(0, GLOBAL_SCREEN_HEIGHT - TABBAR_HEIGHT, GLOBAL_SCREEN_WIDTH, TABBAR_HEIGHT);
            } completion:^(BOOL finished) {
                view.hidden = NO;
            }];
            break;
        }
    }
}

@end
