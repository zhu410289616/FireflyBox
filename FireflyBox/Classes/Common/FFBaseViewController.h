//
//  FFBaseViewController.h
//  FFRunner
//
//  Created by pig on 14-3-28.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConfig.h"

@interface FFBaseViewController : UIViewController

- (IBAction)doBackBarButtonItemAction:(id)sender;
- (IBAction)doLeftBarButtonItemAction:(id)sender;
- (IBAction)doRightBarButtonItemAction:(id)sender;

- (BOOL)searchResult:(NSString *)content searchKeyword:(NSString *)keyword;

@end
