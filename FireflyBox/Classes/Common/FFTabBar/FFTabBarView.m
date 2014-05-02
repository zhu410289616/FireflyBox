//
//  FFTabBarView.m
//  FireflyBox
//
//  Created by pig on 14-4-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFTabBarView.h"
#import "FFTabBarItem.h"

@implementation FFTabBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)tTitleList
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentSelectedIndex = -1;
        
        NSInteger tabBarCount = [tTitleList count];
        float tabBarWidth = frame.size.width / tabBarCount;
        float tabBarHeight = frame.size.height;
        for (int i=0; i<tabBarCount; i++) {
            FFTabBarItem *tabBarItem = [[FFTabBarItem alloc] init];
            tabBarItem.frame = CGRectMake(i * tabBarWidth, 0, tabBarWidth, tabBarHeight);
            tabBarItem.tag = 100 + i;
            tabBarItem.itemTitleLabel.text = [tTitleList objectAtIndex:i];
            [tabBarItem setTitle:[tTitleList objectAtIndex:i] forState:UIControlStateNormal];
            [tabBarItem addTarget:self action:@selector(tabBarItemSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:tabBarItem];
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)tTitleList norIconList:(NSArray *)tNorIconList selIconList:(NSArray *)tSelIconList
{
    return [self initWithFrame:frame titles:tTitleList];
}

- (void)selectedTabBarItem:(NSInteger)tIndex
{
    if (_currentSelectedIndex != tIndex) {
        FFTabBarItem *oldTabBarItem = (FFTabBarItem *)[self viewWithTag:_currentSelectedIndex + 100];
        [oldTabBarItem updateViewWithIsSelected:NO];
        
        FFTabBarItem *newTabBarItem = (FFTabBarItem *)[self viewWithTag:tIndex + 100];
        [newTabBarItem updateViewWithIsSelected:YES];
        _currentSelectedIndex = tIndex;
    }
}

#pragma mark private function

- (IBAction)tabBarItemSelectedAction:(id)sender
{
    FFTabBarItem *tabBarItem = sender;
    NSInteger index = tabBarItem.tag - 100;
    
    BOOL shouldSelected = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(tabBarItem:willSelected:)]) {
        shouldSelected = [_delegate tabBarItem:tabBarItem willSelected:index];
    }
    if (shouldSelected) {
        [self selectedTabBarItem:index];
        if (_delegate && [_delegate respondsToSelector:@selector(tabBarItem:didSelected:)]) {
            [_delegate tabBarItem:tabBarItem didSelected:index];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
