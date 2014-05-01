//
//  FFBaseViewController.m
//  FFRunner
//
//  Created by pig on 14-3-28.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseViewController.h"

@interface FFBaseViewController ()

@end

@implementation FFBaseViewController

- (id)init
{
    if (self = [super init]) {
#ifdef __IPHONE_7_0
        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
#endif
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark bar button item function

- (IBAction)doBackBarButtonItemAction:(id)sender
{
    PLog(@"doBackBarButtonItemAction...");
}

- (IBAction)doLeftBarButtonItemAction:(id)sender
{
    PLog(@"doLeftBarButtonItemAction...");
}

- (IBAction)doRightBarButtonItemAction:(id)sender
{
    PLog(@"doRightBarButtonItemAction...");
}

@end
