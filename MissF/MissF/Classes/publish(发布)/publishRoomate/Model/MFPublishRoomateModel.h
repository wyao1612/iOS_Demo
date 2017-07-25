//
//  MFPublishModel.h
//  MissF
//
//  Created by wyao on 2017/7/18.
//  Copyright © 2017年 wyao. All rights reserved.
//

/** 该模型*/
#import <Foundation/Foundation.h>

@interface MFPublishRoomateModel : NSObject
/** id*/
@property(nonatomic,copy) NSString  *ID;
/** 用户uid*/
@property(nonatomic,copy) NSString  *uid;
/** 地址*/
@property(nonatomic,copy) NSString  *address;
/** 欲搬时间*/
@property(nonatomic,copy) NSString  *datetime;
/** 房屋价格*/
@property(nonatomic,copy) NSString  *money;
/** 个性*/
@property(nonatomic,copy) NSString  *personality;
/** 室友要求*/
@property(nonatomic,copy) NSString  *roommateRequires;
/** 公共设备*/
@property(nonatomic,copy) NSString  *paymentType;
/** 星座*/
@property(nonatomic,copy) NSString  *constellation;
/** 描述*/
@property(nonatomic,copy) NSString  *desc;
/** 职业*/
@property(nonatomic,copy) NSString  *profession;

@end
