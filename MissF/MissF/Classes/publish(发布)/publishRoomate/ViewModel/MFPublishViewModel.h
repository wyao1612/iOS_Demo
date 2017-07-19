//
//  MFPublishViewModel.h
//  MissF
//
//  Created by wyao on 2017/7/18.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFPublishModel.h"
#import "MFRoommateTableViewCell.h"

typedef NS_ENUM(NSInteger , MFPublishVMTag) {
    MF_PublishVM_personality = 0,
    MF_PublishVM_roommateRequires = 1 ,
    MF_PublishVM_paymentType = 2 ,
};

@interface MFPublishViewModel : NSObject
@property(strong,nonatomic) MFPublishModel *publishModel;

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


/**
 将模型里面对应的字符串转成数组
 
 @param tag 标识区别
 @return 数组
 */
-(NSArray*)getArrayFromModelStringWithTag:(MFPublishVMTag)tag;

/**
 将array数组转换为string字符串
 
 @param tag 标识
 @param array 源数组
 @return 字符串
 */
-(NSString*)setModelStringFromArrayWithTag:(MFPublishVMTag)tag andArray:(NSArray*)array;
@end
