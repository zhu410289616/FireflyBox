//
//  FFFileTypeHelper.m
//  FireflyBox
//
//  Created by pig on 14-5-1.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFFileTypeHelper.h"
#import "FFFileViewController.h"
#import "FFFileReaderViewController.h"//default
#import "FFTextReaderViewController.h"

#import "FFTrack.h"
#import "FFMusicPlayerViewController.h"

//
#import "PlayerViewController.h"
#import "Track+Provider.h"

static int tempNum = 1;

@implementation FFFileTypeHelper

- (void)doActionWithFileType
{
    FFFileType fileType = [self checkFileType:_dataInfo.dataPath];
    switch (fileType) {
        case FFFileTypeDirectory:
        {
            FFFileViewController *fileController = [[FFFileViewController alloc] init];
            fileController.title = _dataInfo.dataName;
            fileController.fileDir = _dataInfo.dataPath;
            [_viewController.navigationController pushViewController:fileController animated:YES];
        }
            break;
        case FFFileTypeText:
        {
            [GLOBAL_APP_DELEGATE.tabBarController hideFFTabBarView];
            FFTextReaderViewController *textController = [[FFTextReaderViewController alloc] init];
            textController.title = _dataInfo.dataName;
            textController.filePath = _dataInfo.dataPath;
            [_viewController.navigationController pushViewController:textController animated:YES];
        }
            break;
        case FFFileTypeImage:
        {}
            break;
        case FFFileTypeMusic:
        {
            [GLOBAL_APP_DELEGATE.tabBarController hideFFTabBarView];
            FFMusicPlayerViewController *musicController = [[FFMusicPlayerViewController alloc] init];
            musicController.tracks = [self getMusicInfoList];
            musicController.title = [NSString stringWithFormat:@"Music(%d)", [[self getMusicInfoList] count]];
            [_viewController.navigationController pushViewController:musicController animated:YES];
        }
            break;
        case FFFileTypeVideo:
        {}
            break;
        case FFFileTypeUnkown:
        {
            PLog(@"FFFileTypeUnkown...");
            [GLOBAL_APP_DELEGATE.tabBarController hideFFTabBarView];
            FFFileReaderViewController *readerController = [[FFFileReaderViewController alloc] init];
            readerController.title = _dataInfo.dataName;
            readerController.filePath = _dataInfo.dataPath;
            [_viewController.navigationController pushViewController:readerController animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark private function

- (FFFileType)checkFileType:(NSString *)tFilePath
{
    FFFileType fileType = FFFileTypeUnkown;
    
    NSString *filePath = [tFilePath lowercaseString];
    if (_dataInfo.dataType == FFDataTypeDirectory) {
        fileType = FFFileTypeDirectory;
    } else if ([filePath hasSuffix:@".txt"]) {
        fileType = FFFileTypeText;
    } else if ([filePath hasSuffix:@".png"] || [filePath hasSuffix:@".jpg"]) {
        fileType = FFFileTypeImage;
    } else if ([filePath hasSuffix:@".gif"]) {
        fileType = FFFileTypeImageGif;
    } else if ([filePath hasSuffix:@".m4a"] || [filePath hasSuffix:@".mp3"] || [filePath hasSuffix:@".caf"]) {
        fileType = FFFileTypeMusic;
    } else if ([filePath hasSuffix:@".mp4"]) {
        fileType = FFFileTypeVideo;
    }
    
    if (_fileTypeBlock) {
        _fileTypeBlock(fileType);
    }
    return fileType;
}

- (NSMutableArray *)getMusicInfoList
{
    NSMutableArray *musicInfoList = [[NSMutableArray alloc] init];
    for (FFDataInfo *dataInfo in _dataInfoList) {
        if (FFFileTypeMusic == [self checkFileType:dataInfo.dataPath]) {
            FFTrack *track = [[FFTrack alloc] init];
            track.artist = [NSString stringWithFormat:@"%ld", dataInfo.dataId];
            track.title = dataInfo.dataName;
            track.audioFileURL = [NSURL URLWithString:dataInfo.dataPath];
            [musicInfoList addObject:track];
        }
    }
    
    if ((tempNum++) % 2) {
        [musicInfoList addObjectsFromArray:[Track remoteTracks]];
    } else {
        [musicInfoList addObjectsFromArray:[Track musicLibraryTracks]];
    }
    
    return musicInfoList;
}

@end
