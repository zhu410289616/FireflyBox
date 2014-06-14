//
//  FFTableViewDataSource.m
//  FireflyBox
//
//  Created by pig on 14-6-14.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFTableViewDataSource.h"

@interface FFTableViewDataSource ()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, copy) FFTableViewCellConfigureBlock configureCellBlock;

@end

@implementation FFTableViewDataSource

- (id)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(FFTableViewCellConfigureBlock)aConfigureCellBlock
{
    if (self = [super init]) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = aConfigureCellBlock;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[indexPath.row];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    
    return cell;
}

@end
