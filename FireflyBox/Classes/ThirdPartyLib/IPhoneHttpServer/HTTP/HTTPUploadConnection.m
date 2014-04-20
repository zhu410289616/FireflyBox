//
//  HTTPUploadConnection.m
//  FireflyBox
//
//  Created by pig on 14-4-20.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "HTTPUploadConnection.h"
#import "EGOCache.h"

@implementation HTTPUploadConnection

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Method Support
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Returns whether or not the server will accept messages of a given method
 * at a particular URI.
 **/
- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path
{
    if ([method isEqualToString:@"POST"])
		return YES;
    
    return [super supportsMethod:method atPath:path];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Uploads
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * This method is called after receiving all HTTP headers, but before reading any of the request body.
 **/
- (void)prepareForBodyWithSize:(UInt64)contentLength
{
	// Override me to allocate buffers, file handles, etc.
}

/**
 * This method is called to handle data read from a POST / PUT.
 * The given data is part of the request body.
 **/
- (void)processBodyData:(NSData *)postDataChunk
{
	// Override me to do something useful with a POST / PUT.
	// If the post is small, such as a simple form, you may want to simply append the data to the request.
	// If the post is big, such as a file upload, you may want to store the file to disk.
	//
	// Remember: In order to support LARGE POST uploads, the data is read in chunks.
	// This prevents a 50 MB upload from being stored in RAM.
	// The size of the chunks are limited by the POST_CHUNKSIZE definition.
	// Therefore, this method may be called multiple times for the same POST request.
    
    [[EGOCache currentCache] setData:postDataChunk forKey:@"temp"];
    
}

/**
 * This method is called after the request body has been fully read but before the HTTP request is processed.
 **/
- (void)finishBody
{
	// Override me to perform any final operations on an upload.
	// For example, if you were saving the upload to disk this would be
	// the hook to flush any pending data to disk and maybe close the file.
}

@end
