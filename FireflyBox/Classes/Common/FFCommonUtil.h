//
//  FFCommonUtil.h
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FFCommonUtil : NSObject

+ (NSString *)getCacheHomeDirectory;
+ (NSString *)createPath:(NSString *)tpath;

//磁盘空间信息
+ (long long)getFreeSpace;
+ (float)getTotalDiskSpaceInBytes;
+ (NSString *)formatSpace:(float)tSpaceSize;

//计算文件大小
+ (long long)getLocalFileSize:(NSString *)filepath;
+ (long long)getFileSizeForDir:(NSString *)dir;

//计算两个坐标点间的记录
+ (double)calcDistanceByGpsData:(CLLocation *)location1 currentLocation:(CLLocation *)location2;
+ (double)calcDistance:(double)lat1 longitude1:(double)lng1 latitude2:(double)lat2 longitude2:(double)lng2;
+ (double)calcCalorie:(double)tWeight distance:(double)tDistance;

@end
