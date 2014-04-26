//
//  FFTransferViewController.h
//  FireflyBox
//
//  Created by pig on 14-4-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseViewController.h"
#import "GCDWebUploader.h"

@interface FFTransferViewController : FFBaseViewController<GCDWebUploaderDelegate>

@property (nonatomic, strong) GCDWebUploader *webServer;

@end
