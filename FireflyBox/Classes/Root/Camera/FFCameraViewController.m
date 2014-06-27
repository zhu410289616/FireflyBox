//
//  FFCameraViewController.m
//  FireflyBox
//
//  Created by pig on 14-5-20.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFCameraViewController.h"
#import "libavcodec/avcodec.h"
#import "libavresample/avresample.h"
#import "libavformat/avformat.h"
#import "libswscale/swscale.h"
#import "libswresample/swresample.h"
#import "libavutil/pixdesc.h"
#import "libavutil/avutil.h"
#import "libavutil/opt.h"

@interface FFCameraViewController ()

@end

@implementation FFCameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.backgroundGPUImageView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.backgroundGPUImageView];
    
    //
    self.quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.quitButton.frame = CGRectMake(5, GLOBAL_SCREEN_HEIGHT - 55, 100, 50);
    [self.quitButton setTitle:@"退出" forState:UIControlStateNormal];
    [self.quitButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.quitButton addTarget:self action:@selector(doQuitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.quitButton];
    
    self.recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recordButton.frame = CGRectMake(200, GLOBAL_SCREEN_HEIGHT - 55, 100, 50);
    [self.recordButton setTitle:@"开始" forState:UIControlStateNormal];
    [self.recordButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.recordButton setImage:[UIImage imageNamed:@"RecordDot.png"] forState:UIControlStateNormal] ;
    [self.recordButton addTarget:self action:@selector(doVideoRecordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.recordButton];
    
    //
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionBack];
    self.videoCamera.delegate = self;
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.horizontallyMirrorFrontFacingCamera = YES;
    self.videoCamera.horizontallyMirrorRearFacingCamera = NO;
    
    //
    self.videoBuffer = [[GPUImageBuffer alloc] init];
    self.videoBuffer.bufferSize = 1;
    [self.videoBuffer addTarget:self.backgroundGPUImageView];
    //
    [self.videoCamera addTarget:self.videoBuffer];
    [self.videoCamera startCameraCapture];
    
    //init path
    [self initMovieWriterDir];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark privte function

- (void)initMovieWriterDir
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    self.movieWriterPath = [FFCommonUtil createPath:[NSString stringWithFormat:@"%@%@/", documentsPath, MOVIE_WRITER_SAVE_DIR]];
}

- (IBAction)doQuitAction:(id)sender
{
    if (self.isRecording) {
        [self doVideoRecordAction:nil];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doVideoRecordAction:(id)sender
{
    if (self.isRecording) {
        self.isRecording = NO;
        [self.videoCamera removeTarget:self.movieWriter];
        [self.movieWriter finishRecording];
        
        [self.recordButton setImage:[UIImage imageNamed:@"RecordDot.png"] forState:UIControlStateNormal] ;
        [self.recordButton setTitle:@"开始" forState:UIControlStateNormal];
    } else {
        self.isRecording = YES;
        NSString *pathForMovie = [NSString stringWithFormat:@"%@%@.m4v", self.movieWriterPath, [NSString stringWithDate:[NSDate date] formatter:@"yyyy-MM-dd-HHmmss"]];
        NSURL *movieURL = [NSURL fileURLWithPath:pathForMovie];
        self.movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:self.backgroundGPUImageView.frame.size];
        [self.videoCamera addTarget:self.movieWriter];
        [self.movieWriter startRecording];
        
        [self.recordButton setImage:[UIImage imageNamed:@"RecordStop.png"] forState:UIControlStateNormal] ;
        [self.recordButton setTitle:@"停止" forState:UIControlStateNormal];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // Map UIDeviceOrientation to UIInterfaceOrientation.
    UIInterfaceOrientation orient = UIInterfaceOrientationPortrait;
    switch ([[UIDevice currentDevice] orientation])
    {
        case UIDeviceOrientationLandscapeLeft:
            orient = UIInterfaceOrientationLandscapeLeft;
            break;
            
        case UIDeviceOrientationLandscapeRight:
            orient = UIInterfaceOrientationLandscapeRight;
            break;
            
        case UIDeviceOrientationPortrait:
            orient = UIInterfaceOrientationPortrait;
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            orient = UIInterfaceOrientationPortraitUpsideDown;
            break;
            
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationUnknown:
            // When in doubt, stay the same.
            orient = fromInterfaceOrientation;
            break;
    }
    self.videoCamera.outputImageOrientation = orient;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES; // Support all orientations.
}

#pragma mark GPUImageVideoCameraDelegate method

- (void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    if (NULL == sampleBuffer) {
        return;
    }
    
    // For now, resize photos to fix within the max texture size of the GPU
    CVImageBufferRef cameraFrame = CMSampleBufferGetImageBuffer(sampleBuffer);
    [self dataEncodePixelBuffer:cameraFrame];
    
}

- (NSData *)dataEncodePixelBuffer:(CVImageBufferRef)pixelBuffer
{
    int width = CVPixelBufferGetWidth(pixelBuffer);
    int height = CVPixelBufferGetHeight(pixelBuffer);
    unsigned char *rawPixelBase = (unsigned char *)CVPixelBufferGetBaseAddress(pixelBuffer);
    AVFrame *pFrame = avcodec_alloc_frame();
    pFrame->quality = 0;
    AVFrame *outpic = avcodec_alloc_frame();
    avpicture_fill((AVPicture *)pFrame, rawPixelBase, PIX_FMT_BGRA, width, height);
    
    //FILE *f;
    uint8_t *outbuf;
    AVCodec *codec = avcodec_find_encoder(AV_CODEC_ID_H264);//找到编码器
    if (!codec) {
        fprintf(stderr, "codec not found\n");
        exit(1);
    }
    
    AVCodecContext *c = avcodec_alloc_context3(codec);
    c->bit_rate = 240000;
    c->width = 352;
    c->height = 288;
    c->time_base = (AVRational){1, 25};
    c->gop_size = 10;
    c->max_b_frames = 1;
    c->pix_fmt = PIX_FMT_YUV420P;
    c->thread_count = 1;
    av_opt_set(c->priv_data, "preset", "slow", 0);
    
    if (avcodec_open2(c, codec, NULL) < 0) {
        fprintf(stderr, "could not open codec\n");
        exit(1);
    }
    /* alloc image and output buffer */
    int out_size, size, outbuf_size;
    outbuf_size = 100000;
    outbuf = malloc(outbuf_size);
    size = c->width *c->height;
    
    AVPacket avpkt;
    int nbytes = avpicture_get_size(PIX_FMT_YUV420P, c->width, c->height);
    //create buffer for the output image
    uint8_t *outbuffer = (uint8_t *)av_malloc(nbytes);
    
    avpicture_fill((AVPicture *)outpic, outbuffer, PIX_FMT_YUV420P, c->width, c->height);
    
    struct SwsContext *fooContxt = sws_getContext(c->width, c->height, PIX_FMT_BGR32, c->width, c->height, PIX_FMT_YUV420P, SWS_POINT, NULL, NULL, NULL);
    pFrame->data[0] += pFrame->linesize[0] * (height - 1);
    pFrame->linesize[0] *= -1;
    pFrame->data[1] += pFrame->linesize[1] * (height / 2 - 1);
    pFrame->linesize[1] *= -1;
    pFrame->data[2] += pFrame->linesize[2] * (height / 2 - 1);
    pFrame->linesize[2] *= -1;
    
    int xx = sws_scale(fooContxt, (const uint8_t **)pFrame->data, pFrame->linesize, 0, c->height, outpic->data, outpic->linesize);
    //Here is where i try to convert to YUV
    //encode the image
    int got_packet_ptr = 0;
    av_init_packet(&avpkt);
    avpkt.size = 0;
    avpkt.data = NULL;//outbuf
    
    out_size = avcodec_encode_video2(c, &avpkt, outpic, &got_packet_ptr);
    
    printf("encoding frame (size=%5d)\n", out_size);
    printf("encoding frame %s\n", avpkt.data);
    
    return nil;
}

@end
