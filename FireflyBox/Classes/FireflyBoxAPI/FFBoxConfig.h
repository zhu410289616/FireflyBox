//
//  FFBoxConfig.h
//  FireflyBox
//
//  Created by pig on 14-5-25.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#ifndef FireflyBox_FFBoxConfig_h
#define FireflyBox_FFBoxConfig_h

//transfer web server
#define TRANSFER_WEB_SERVER_NAME        @"firefly"
#define TRANSFER_WEB_SERVER_PORT        20144
#define TRANSFER_WEB_SERVER_DIR         @"/WebServer"

#define SHOULD_UPDATE_FILE_INFO         @"SHOULD_UPDATE_FILE_INFO"

//audio recorder
#define kBufferDurationSeconds .5
#define AUDIO_RECORDER_SAVE_DIR         @"/WebServer/MyAudio"

//webservice
//domain
#define WEBSERVICE_DOMAIN                       @"http://fireflybox.sinaapp.com"

#define WEBSERVICE_GET_DAILY_TEXT               @"/get_daily_text.php"

#endif
