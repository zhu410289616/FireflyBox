//
//  FFTransferViewController.m
//  FireflyBox
//
//  Created by pig on 14-4-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFTransferViewController.h"
#import "FFBarButtonItem.h"

@interface FFTransferViewController ()

@end

@implementation FFTransferViewController

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
    
    self.title = @"传输";
    self.view.backgroundColor = [UIColor whiteColor];
    
    FFBarButtonItem *tempBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = tempBarButtonItem;
    
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    contentScrollView.frame = CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, GLOBAL_SCREEN_HEIGHT);
    
    UIImage *transferTipImage = [[UIImage imageWithName:@"transfer_bg" type:@"png"] resizableImageWithCapInsets:UIEdgeInsetsMake(180, 0, 20, 0)];
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    backgroundImageView.frame = CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, GLOBAL_SCREEN_HEIGHT);
    backgroundImageView.image = transferTipImage;
    [contentScrollView addSubview:backgroundImageView];
    
    float margin = 25.0f;
    
    UILabel *tip1Label = [[UILabel alloc] init];
    tip1Label.frame = CGRectMake(margin, 180, GLOBAL_SCREEN_WIDTH - margin * 2, 25);
    tip1Label.backgroundColor = [UIColor clearColor];
    tip1Label.textAlignment = NSTextAlignmentLeft;
    tip1Label.textColor = [UIColor blackColor];
    tip1Label.font = [UIFont fontOfApp:13.0f];
    tip1Label.text = @"1.请确保您的电脑和手机再同一个wifi网络下。";
    [contentScrollView addSubview:tip1Label];
    
    UILabel *tip2Label = [[UILabel alloc] init];
    tip2Label.frame = CGRectMake(margin, 205, GLOBAL_SCREEN_WIDTH - margin * 2, 25);
    tip2Label.backgroundColor = [UIColor clearColor];
    tip2Label.textAlignment = NSTextAlignmentLeft;
    tip2Label.textColor = [UIColor blackColor];
    tip2Label.font = [UIFont fontOfApp:13.0f];
    tip2Label.text = @"2.请在电脑浏览器中输入以下地址:";
    [contentScrollView addSubview:tip2Label];
    
    UILabel *tip3Label = [[UILabel alloc] init];
    tip3Label.frame = CGRectMake(margin, 250, GLOBAL_SCREEN_WIDTH - margin * 2, 25);
    tip3Label.backgroundColor = [UIColor clearColor];
    tip3Label.textAlignment = NSTextAlignmentCenter;
    tip3Label.textColor = [UIColor blueColor];
    tip3Label.font = [UIFont fontOfApp:16.0f];
    [contentScrollView addSubview:tip3Label];
    
    [self.view addSubview:contentScrollView];
    
    //
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _webServer = [[GCDWebUploader alloc] initWithUploadDirectory:documentsPath];
    _webServer.delegate = self;
    _webServer.allowHiddenItems = YES;
    BOOL isStart = [_webServer startWithPort:TRANSFER_WEB_SERVER_PORT bonjourName:TRANSFER_WEB_SERVER_NAME];
    if (isStart) {
        tip3Label.text = _webServer.serverURL.absoluteString;
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doRightBarButtonItemAction:(id)sender
{
    _webServer.delegate = nil;
    [_webServer stop];
    _webServer = nil;
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark GCDWebUploaderDelegate method

/**
 *  This method is called whenever a file has been downloaded.
 */
- (void)webUploader:(GCDWebUploader*)uploader didDownloadFileAtPath:(NSString*)path
{
    PLog(@"[DOWNLOAD] %@", path);
}

/**
 *  This method is called whenever a file has been uploaded.
 */
- (void)webUploader:(GCDWebUploader*)uploader didUploadFileAtPath:(NSString*)path
{
    PLog(@"[UPLOAD] %@", path);
}

/**
 *  This method is called whenever a file or directory has been moved.
 */
- (void)webUploader:(GCDWebUploader*)uploader didMoveItemFromPath:(NSString*)fromPath toPath:(NSString*)toPath
{
    PLog(@"[MOVE] %@ -> %@", fromPath, toPath);
}

/**
 *  This method is called whenever a file or directory has been deleted.
 */
- (void)webUploader:(GCDWebUploader*)uploader didDeleteItemAtPath:(NSString*)path
{
    PLog(@"[DELETE] %@", path);
}

/**
 *  This method is called whenever a directory has been created.
 */
- (void)webUploader:(GCDWebUploader*)uploader didCreateDirectoryAtPath:(NSString*)path
{
    PLog(@"[CREATE] %@", path);
}

@end
