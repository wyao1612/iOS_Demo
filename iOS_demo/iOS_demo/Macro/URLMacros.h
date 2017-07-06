//
//  URLMacros.h
//  iOS_demo
//
//  Created by wyao on 2017/6/20.
//  Copyright © 2017年 wyao. All rights reserved.
//


//定义服务器接口地址以及环境开关；
#ifndef URLMacros_h
#define URLMacros_h

//Coding App 的专属链接
#define kCodingAppScheme @""


#define kAppUrl         @""//appStore地址
#define kAppReviewURL   @""//检查更新


//API
#ifdef DEBUG
    #define HostAPI   @"http://api.miss-f.cn/app_dev.php/api/v1"
#else
    #define HostAPI   @"http://api.miss-f.cn/app_dev.php/api/v1"
#endif


/**login*/
#define kPostLogin_Code @"/sms/send/mobile.json"
#define kPostLogin @"/user/login.json"

#endif /* URLMacros_h */
