//
//  MFLocationManager.h
//  MissF
//
//  Created by wyao on 2017/7/22.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MFLocationManager : NSObject
+ (instancetype)manager;

/// 开始定位
- (void)startLocation;
- (void)startLocationWithSuccessBlock:(void (^)(CLLocation *location,CLLocation *oldLocation))successBlock failureBlock:(void (^)(NSError *error))failureBlock;
- (void)startLocationWithGeocoderBlock:(void (^)(NSArray *geocoderArray))geocoderBlock;
- (void)startLocationWithSuccessBlock:(void (^)(CLLocation *location,CLLocation *oldLocation))successBlock failureBlock:(void (^)(NSError *error))failureBlock geocoderBlock:(void (^)(NSArray *geocoderArray))geocoderBlock;
@end
