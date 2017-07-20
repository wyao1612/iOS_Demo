//
//  MFAdressModel.h
//  MissF
//
//  Created by wyao on 2017/7/19.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFAdressModel : NSObject
/**
 poi的id
 */
@property (nonatomic, copy) NSString *uid;

/**
 名称
 */
@property (nonatomic, copy) NSString *name;

/**
 区域编码
 */
@property (nonatomic, copy) NSString *adcode;

/**
 所属区域
 */
@property (nonatomic, copy) NSString *district;

/**
 地址
 */
@property (nonatomic, copy) NSString *address;

/**
 纬度（垂直方向
 */
@property (nonatomic, assign) double latitude;

/**
 经度（水平方向）
 */
@property (nonatomic, assign) double longitude;
@end
