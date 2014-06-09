//
//  FFPhotosDataSource.h
//  FireflyBox
//
//  Created by pig on 14-6-9.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFPhotosDataSource : NSObject

@property (nonatomic, strong) NSArray *photos;
@property (readonly) NSUInteger count;

- (void)photoForIndex:(NSUInteger)index withCompletionBlock:(void (^)(UIImage *, NSError *))completionBlock;

@end
