//
//  FFAboutViewController.m
//  FireflyBox
//
//  Created by pig on 14-5-2.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFAboutViewController.h"

@interface FFAboutViewController ()

@end

@implementation FFAboutViewController

- (id)init
{
    if (self = [super init]) {
        self.title = @"关于";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImage *iconImage = [UIImage imageNamed:@"Icon_200_200.png"];
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.frame = CGRectMake((GLOBAL_SCREEN_WIDTH - 100) / 2, 35, 100, 100);
    iconImageView.image = iconImage;
    iconImageView.layer.cornerRadius = 50.0f;
    iconImageView.layer.masksToBounds = YES;
    [self.view addSubview:iconImageView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(0, iconImageView.frame.origin.y + iconImageView.frame.size.height + 10, GLOBAL_SCREEN_WIDTH, 30);
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont fontOfApp:20.0f];
    nameLabel.text = [NSString stringWithFormat:@"%@", @"赤兔文件U盘"];
    [self.view addSubview:nameLabel];
    
    UILabel *versionLabel = [[UILabel alloc] init];
    versionLabel.frame = CGRectMake(0, nameLabel.frame.origin.y + nameLabel.frame.size.height + 10, GLOBAL_SCREEN_WIDTH, 20);
    versionLabel.backgroundColor = [UIColor clearColor];
	versionLabel.font = [UIFont systemFontOfSize:16];
    versionLabel.textAlignment = NSTextAlignmentCenter;
	versionLabel.textColor = [UIColor colorWithHex:0x808080];
    versionLabel.text = [NSString stringWithFormat:@"Version %@", [FFCommonUtil getBundleVersion]];
	[self.view addSubview:versionLabel];
	
	UILabel *copyrightLabel = [[UILabel alloc] init];
    copyrightLabel.frame = CGRectMake(0, versionLabel.frame.origin.y + versionLabel.frame.size.height + 30, GLOBAL_SCREEN_WIDTH, 20);
    copyrightLabel.backgroundColor = [UIColor clearColor];
    copyrightLabel.textAlignment = NSTextAlignmentCenter;
	copyrightLabel.font = [UIFont systemFontOfSize:16];
	copyrightLabel.textColor = [UIColor colorWithHex:0x808080];
    copyrightLabel.text = [NSString stringWithFormat:@"%@", @"Copyright © 2014 赤兔"];
	[self.view addSubview:copyrightLabel];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [GLOBAL_APP_DELEGATE.tabBarController hideFFTabBarView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
