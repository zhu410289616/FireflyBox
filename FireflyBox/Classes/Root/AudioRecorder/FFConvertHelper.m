//
//  FFConvertHelper.m
//  FireflyBox
//
//  Created by pig on 14-5-20.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFConvertHelper.h"
#import "lame.h"

const static int PCM_SIZE = 8192;
const static int MP3_SIZE = 8192;

@implementation FFConvertHelper

+ (void)convertToMp3WithCafFilePath:(NSString *)tCafFilePath
{
    NSString *mp3FilePath = [tCafFilePath stringByReplacingOccurrencesOfString:[tCafFilePath pathExtension] withString:@"mp3"];
    FFLOG_FORMAT(@"mp3FilePath: %@", mp3FilePath);
    
    [self convertCaf2Mp3:tCafFilePath destPath:mp3FilePath];
    
}

+ (void)convertCaf2Mp3:(NSString *)tSrcPath destPath:(NSString *)tDestPath
{
    @try {
        int read, write;
        
        FILE *pcm = fopen([tSrcPath cStringUsingEncoding:1], "rb");//被转换的文件
        if (NULL != pcm) {
            fseek(pcm, 4*1024, SEEK_CUR);//skip file header
            FILE *mp3 = fopen([tDestPath cStringUsingEncoding:1], "wb");//转换后文件的存放位置
            
            short int pcm_buffer[PCM_SIZE*2];
            unsigned char mp3_buffer[MP3_SIZE];
            
            lame_t lame = lame_init();
            lame_set_in_samplerate(lame, 22050.0);//44100
            lame_set_VBR(lame, vbr_default);
            lame_init_params(lame);
            
            do {
                read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
                if (read == 0)
                    write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
                else
                    write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
                
                fwrite(mp3_buffer, write, 1, mp3);
                
            } while (read != 0);
            
            lame_close(lame);
            fclose(mp3);
            fclose(pcm);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    
}

@end
