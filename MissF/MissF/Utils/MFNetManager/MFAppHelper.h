//
//  MFAppHelper.h
//  iOS_demo
//
//  Created by wyao on 2017/7/4.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSInteger, CHAppHelperReachabilityStatus) {
    CHAppHelperReachabilityStatusUnknown          = -1,
    CHAppHelperReachabilityStatusNotReachable     = 0,
    CHAppHelperReachabilityStatusReachableViaWWAN = 1,
    CHAppHelperReachabilityStatusReachableViaWiFi = 2,
};

@interface MFAppHelper : NSObject
@property (readonly, nonatomic, assign) CHAppHelperReachabilityStatus networkReachabilityStatus;

+ (instancetype)sharedInstance;

/**
 *  开启地理位置定位服务
 *
 *  @param completion 定位完成地理信息对象
 */
- (void)openLocationServiceOnCompletion:(void (^)(CLPlacemark *placemark))completion;

/**
 *  开启检测网络变化 === 变化结果 可通过 networkReachabilityStatus 获取
 */
- (void)startCheckNetwork;

// 需要先开启 startCheckNetwork 并且没有stopCheckNetwork 否则数据有误
- (BOOL)isReachable;

- (BOOL)isReachableViaWWAN;

- (BOOL)isReachableViaWiFi;

@end
