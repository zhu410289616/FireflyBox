//
//  FFTableViewDataSource.h
//  FireflyBox
//
//  Created by pig on 14-6-14.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FFTableViewCellConfigureBlock)(id cell, id item);

@interface FFTableViewDataSource : NSObject<UITableViewDataSource>

- (id)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(FFTableViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
