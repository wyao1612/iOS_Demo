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
    #define HostAPI   @"https://api.miss-f.cn/app_dev.php/api/v1"
#else
    #define HostAPI   @"https://api.miss-f.cn/app_dev.php/api/v1"
#endif

/** 本地数据缓存表示*/
static NSString *const  MFLocalCache = @"MFNetworkCache";
static NSString *const  httpCache = @"MFNetworkCache";


/** login*/
#define kPostLogin_Code @"/sms/send/mobile.json"
#define kPostLogin @"/user/login.json"


/** accessToken和refreshToken*/
#define  ACCESSTOKEN @"accessToken"
#define  REFRESHTOKEN @"refreshToken"

/** 我的发布房源列表*/
#define kHouseList          @"/publish/house/list.json" 
#define kHousePeople        @"/publish/people.json"
#define kHouse              @"/publish/house.json"
#define kHouseDelete        @"/publish/house/delete.json"


/** 公共字典*/
#define kcommonUrl  @"/common/configure.json"

/** 上传图片数组*/
#define kupload  @"/upload/file.json"

#endif /* URLMacros_h */
