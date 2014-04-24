//
//  FFHomeViewController.m
//  FireflyBox
//
//  Created by pig on 14-4-20.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFHomeViewController.h"
#import "FFBarButtonItem.h"
#import "FFTransferViewController.h"

#import "NetworkController.h"
#import "AppDelegate.h"

@interface FFHomeViewController ()

@end

@implementation FFHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"Home";
    
    FFBarButtonItem *tempBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = tempBarButtonItem;
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    HTTPServer *httpServer = appDelegate.httpServer;
    
    UILabel *serverInfoLabel = [[UILabel alloc] init];
    serverInfoLabel.frame = CGRectMake(15, 80, 200, 50);
    serverInfoLabel.backgroundColor = [UIColor clearColor];
    serverInfoLabel.text = [NSString stringWithFormat:@"server: %@:%hu", [NetworkController localWifiIPAddress], [httpServer listeningPort]];
    serverInfoLabel.textColor = [UIColor colorWithHex:0x454545];
    [self.view addSubview:serverInfoLabel];
    
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

- (IBAction)doRightBarButtonItemAction:(id)sender
{
    FFTransferViewController *transferController = [[FFTransferViewController alloc] init];
    [self.navigationController pushViewController:transferController animated:YES];
}

@end
