//
//  FFFileTypeIconView.m
//  FireflyBox
//
//  Created by pig on 14-5-2.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFFileTypeIconView.h"

@implementation FFFileTypeIconView

- (id)init
{
    if (self = [super init]) {
        self.layer.cornerRadius = 20.0f;
        self.layer.masksToBounds = YES;
        
        _fileTypeLabel = [[UILabel alloc] init];
        _fileTypeLabel.backgroundColor = [UIColor clearColor];
        _fileTypeLabel.textAlignment = NSTextAlignmentCenter;
        _fileTypeLabel.textColor = [UIColor whiteColor];
        _fileTypeLabel.font = [UIFont fontWithBoldOfApp:14.0f];
        [self addSubview:_fileTypeLabel];
    }
    return self;
}

- (void)updateViewWithTitle:(NSString *)title showColor:(UIColor *)showColor
{
    self.backgroundColor = showColor;
    _fileTypeLabel.frame = self.bounds;
    _fileTypeLabel.text = (title.length > 4) ? [title substringToIndex:4] : title;
}

@end
