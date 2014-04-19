//
//  FFCommonUtil.m
//  FFRunner
//
//  Created by pig on 14-3-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFCommonUtil.h"

double dd = M_PI/180;
double R = 6371004;

@implementation FFCommonUtil

+ (NSString *)getCacheHomeDirectory{
    
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cacheHomeDirectory = [cachesDirectory stringByAppendingPathComponent:[[NSProcessInfo processInfo] processName]];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:cacheHomeDirectory isDirectory:NULL])
    {
        [fm createDirectoryAtPath:cacheHomeDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return cacheHomeDirectory;
}

+ (NSString *)createPath:(NSString *)tpath{
    
    NSString *temppath = tpath;
    
    if (tpath == nil)
    {
        temppath = [self getCacheHomeDirectory];
    }
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:temppath isDirectory:NULL])
    {
        [fm createDirectoryAtPath:temppath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return temppath;
}

+ (long long)getLocalFileSize:(NSString *)filepath
{
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:filepath isDirectory:NULL])
    {
        return 0;
    }
    NSDictionary *fileAttributes = [fm attributesOfItemAtPath:filepath error:nil];
    return [fileAttributes fileSize];
}

//计算文件夹下文件的总大小
+ (long long)getFileSizeForDir:(NSString *)dir{
    
    long long size = 0;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *filelist = [fileManager contentsOfDirectoryAtPath:dir error:nil];
    NSUInteger fileCount = [filelist count];
    for (NSUInteger i=0; i<fileCount; i++)
    {
        NSString *fullPath = [dir stringByAppendingPathComponent:[filelist objectAtIndex:i]];
        NSLog(@"fullPath: %@", fullPath);
        
        size += [self getLocalFileSize:fullPath];
    }
    
    return size;
}

//计算两个坐标点间的记录(单位米)
+ (double)calcDistanceByGpsData:(CLLocation *)location1 currentLocation:(CLLocation *)location2
{
    double runDistance = 0;
    if (location1 && location2) {
        double lat1 = location1.coordinate.latitude;
        double lng1 = location1.coordinate.longitude;
        double lat2 = location2.coordinate.latitude;
        double lng2 = location2.coordinate.longitude;
        runDistance = [self calcDistance:lat1 longitude1:lng1 latitude2:lat2 longitude2:lng2];
        runDistance = (runDistance < 0) ? (-runDistance) : runDistance;
    }
    return runDistance;
}

//计算两个坐标点间的记录(单位米)
+ (double)calcDistance:(double)lat1 longitude1:(double)lng1 latitude2:(double)lat2 longitude2:(double)lng2
{
    double runDistance = 0;
    if (fabs(lat1 - lat2) < 0.00001 || fabs(lng1 - lng2) < 0.00001) {
        return runDistance;
    }
    
    double x1 = lat1 * dd;
    double y1 = lng1 * dd;
    double x2 = lat2 * dd;
    double y2 = lng2 * dd;
    runDistance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    runDistance = (runDistance < 0) ? (-runDistance) : runDistance;
    return runDistance;
}

/*
 * 已知体重,距离,计算卡路里消耗
 * 跑步热量（kcal）＝体重（kg）×距离（公里）×1.036
 *
 * 例如：体重60公斤的人，长跑8公里，那么消耗的热量＝60×8×1.036＝497.28 kcal(千卡)
 */
+ (double)calcCalorie:(double)tWeight distance:(double)tDistance
{
    return tWeight * tDistance * 1.036;
}

//
+ (NSString *)formatDate:(NSDate *)tempDate formatter:(NSString *)formatter{
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-DD"];
    if (formatter) {
        [dateformatter setDateFormat:formatter];
    }
    
    NSString *strTime = [dateformatter stringFromDate:tempDate];
    
    return strTime;
}

+(NSString *)formatTime:(long)timeTnterval formatter:(NSString *)formatter{
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-DD"];
    if (formatter) {
        [dateformatter setDateFormat:formatter];
    }
    
    NSDate *tempDate = [NSDate dateWithTimeIntervalSince1970:timeTnterval];
    NSString *strTime = [dateformatter stringFromDate:tempDate];
    
    return strTime;
}

@end
