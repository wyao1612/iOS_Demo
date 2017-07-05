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
    #define HostAPI   @"http://api.miss-f.cn/app_dev.php"
#else
    #define HostAPI   @"http://api.miss-f.cn/app_dev.php"
#endif


#endif /* URLMacros_h */
