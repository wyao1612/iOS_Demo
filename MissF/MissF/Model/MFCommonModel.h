//
//  MFCommonModel.h
//  MissF
//
//  Created by wyao on 2017/7/14.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 基类公共模型
 */
@interface MFCommonBaseModel : NSObject
@property(copy,nonatomic) NSString* ID;
@property(copy,nonatomic) NSString* name;
@end

/**
 家居模型
 */
@interface MFPaymentTypeModel : MFCommonBaseModel
@property(copy,nonatomic) NSString* key;
@end

/**
 职业模型
 */
@interface MFProfessionModel : MFCommonBaseModel
@property(copy,nonatomic) NSString* parent;
@property(copy,nonatomic) NSString* color;
@end

/**
 基类生肖和星座公共模型
 */
@interface MFSymbolicBaseModel : NSObject
/** id*/
@property(nonatomic,copy) NSString  *ID;
/** 星座英文*/
@property(nonatomic,copy) NSString  *en;
/** 星座中文*/
@property(nonatomic,copy) NSString  *cn;
@end


@class facilitiesModel;
@class MFtagsModel;


@interface MFCommonModel : NSObject
/** 支付方式*/
@property(nonatomic,strong) NSMutableArray<MFPaymentTypeModel*>  *paymentType;
/** 房间最大数*/
@property(nonatomic,copy) NSString  *houseRoomMax;
/** 客厅最大数*/
@property(nonatomic,copy) NSString  *houseHallMax;
/** 卫生间最大数*/
@property(nonatomic,copy) NSString  *houseToiletMax;
/** 楼层最大数*/
@property(nonatomic,copy) NSString  *houseFloorMax;
/** 家居设备 room：对应房间 common：公共区域设备*/
@property(nonatomic,strong) facilitiesModel  *facilities;
/** 星座*/
@property(nonatomic,strong) NSMutableArray <MFSymbolicBaseModel*>  *constellation;
/** 生肖*/
@property(nonatomic,strong) NSMutableArray <MFSymbolicBaseModel*>  *chineseZodiac;
/** 标签属性*/
@property(nonatomic,strong) MFtagsModel  *tag;
/** 室友要求*/
@property(nonatomic,strong) NSMutableArray <MFCommonBaseModel*>  *roommateRequires;
/** 职业*/
@property(nonatomic,strong) NSMutableArray <MFProfessionModel*>  *profession;
@end


/************************设备家具****************/
@interface facilitiesModel : MFCommonBaseModel
/** 对应房间*/
@property(nonatomic,strong) NSMutableArray<MFCommonBaseModel*>  *room;
/** 公共区域设备*/
@property(nonatomic,strong) NSMutableArray<MFCommonBaseModel*>  *common;
@end


/************************个性标签******************/
@interface MFtagsModel : NSObject
/** 兴趣*/
@property(strong,nonatomic) NSMutableArray<MFCommonBaseModel*>     *interest;
/** 习惯*/
@property(strong,nonatomic) NSMutableArray<MFCommonBaseModel*>     *habit;
/** 个性*/
@property(strong,nonatomic) NSMutableArray<MFCommonBaseModel*>     *personality;
@end




