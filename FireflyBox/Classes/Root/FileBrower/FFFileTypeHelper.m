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
    FFFileType fileType = _dataInfo.fileType;
    switch (fileType) {
        case FFFileTypeDirectory:
        {
            FFFileViewController *fileController = [[FFFileViewController alloc] init];
            fileController.title = _dataInfo.dataName;
            fileController.parentDataId = _dataInfo.dataId;
            fileController.fileDir = _dataInfo.dataPath;
            [_viewController.navigationController pushViewController:fileController animated:YES];
        }
            break;
        case FFFileTypeText:
        {
            FFTextReaderViewController *textController = [[FFTextReaderViewController alloc] init];
            textController.title = _dataInfo.dataName;
            textController.filePath = _dataInfo.dataPath;
            [_viewController.navigationController pushViewController:textController animated:YES];
        }
            break;
        case FFFileTypeMusic:
        {
            [self doGotoPlayerController];
        }
            break;
        case FFFileTypeVideo:
        {}
            break;
        case FFFileTypePdf:
        case FFFileTypeImage:
        case FFFileTypeHtml:
        case FFFileTypePlist:
        {
            FFFileReaderViewController *readerController = [[FFFileReaderViewController alloc] init];
            readerController.title = _dataInfo.dataName;
            readerController.filePath = _dataInfo.dataPath;
            [_viewController.navigationController pushViewController:readerController animated:YES];
        }
            break;
        case FFFileTypeUnkown:
        {
            PLog(@"FFFileTypeUnkown...");
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

#pragma mark music --------------------

- (void)doGotoPlayerController
{
    int selectIndex = 0;
    int tempIndex = 0;
    NSMutableArray *musicInfoList = [[NSMutableArray alloc] init];
    for (int i=0; i<[_dataInfoList count]; i++) {
        FFDataInfo *tempdatainfo = [_dataInfoList objectAtIndex:i];
        if (FFFileTypeMusic == tempdatainfo.fileType) {
            FFTrack *track = [[FFTrack alloc] init];
            track.artist = [NSString stringWithFormat:@"%ld", tempdatainfo.dataId];
            track.title = tempdatainfo.dataName;
            track.audioFileURL = [NSURL fileURLWithPath:tempdatainfo.dataPath isDirectory:NO];
            [musicInfoList addObject:track];
            
            if (_dataInfo.dataId == tempdatainfo.dataId) {
                selectIndex = tempIndex;
            }
            tempIndex++;
        }
    }
    
    FFMusicPlayerViewController *musicController = [[FFMusicPlayerViewController alloc] init];
    musicController.tracks = [self getMusicInfoList];
    musicController.currentTrackIndex = selectIndex;
    musicController.title = [NSString stringWithFormat:@"Music(%d)", [[self getMusicInfoList] count]];
    [_viewController.navigationController pushViewController:musicController animated:YES];
}

- (NSMutableArray *)getMusicInfoList
{
    NSMutableArray *musicInfoList = [[NSMutableArray alloc] init];
    for (FFDataInfo *dataInfo in _dataInfoList) {
        if (FFFileTypeMusic == dataInfo.fileType) {
            FFTrack *track = [[FFTrack alloc] init];
            track.artist = [NSString stringWithFormat:@"%ld", dataInfo.dataId];
            track.title = dataInfo.dataName;
            track.audioFileURL = [NSURL fileURLWithPath:dataInfo.dataPath isDirectory:NO];
            [musicInfoList addObject:track];
        }
    }
    
    if ((tempNum++) % 2) {
//        [musicInfoList addObjectsFromArray:[Track remoteTracks]];
    } else {
        [musicInfoList addObjectsFromArray:[Track musicLibraryTracks]];
    }
    
    return musicInfoList;
}

@end
