//
//  MFPublishViewModel.h
//  MissF
//
//  Created by wyao on 2017/7/18.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFPublishRoomateModel.h"
#import "MFPublishHouseModel.h"
#import "MFRoommateTableViewCell.h"
#import "HXPhotoModel.h"

typedef NS_ENUM(NSInteger , MFPublishVMTag) {
    MF_PublishVM_personality = 0,
    MF_PublishVM_roommateRequires = 1 ,
    MF_PublishVM_paymentType = 2 ,
};

@interface MFPublishViewModel : NSObject
/** 发布室友模型*/
@property(strong,nonatomic) MFPublishRoomateModel *roomateModel;
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
/** 室友要求数组*/
@property (strong, nonatomic) NSMutableArray *roommateRequiresSelectedArray;
/** 个性标签数组*/
@property (strong, nonatomic) NSMutableArray<NSString*> *allTagsSelectedArray;

/******************************发布房源***************************/
/** 发布房屋模型*/
@property(strong,nonatomic) MFPublishHouseModel *houseModel;
/** 对应房间的模型数组*/
@property(strong,nonatomic) NSMutableArray<houseRoomModel*> *houseRoomModelArray;
/** 获取房屋名称*/
-(NSString *)getHouseNameFromIndex:(NSInteger)index;
/** 获取房屋金额*/
-(NSString *)getHousePriceFromIndex:(NSInteger)index;
/** 获取房屋类型*/
-(NSString *)getHouseRoomTypeFromIndex:(NSInteger)index;
/** 获取房屋朝向*/
-(NSString *)getHouseOrientateFromIndex:(NSInteger)index;
/** 房屋Id*/
@property(nonatomic,copy) NSString  *userHouseId;
/** 房屋类型 主卧 次卧*/
@property(nonatomic,copy) NSString  *roomType;
/** orientate*/
@property(nonatomic,copy) NSString  *orientate;
/** 封面照片数组*/
@property(nonatomic,strong) NSArray  *images;


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


/** 所有上传的照片二维数组记录对应的照片选择器*/
@property(nonatomic,strong)NSMutableArray<NSMutableArray*> *allPhotoArray;
/** 所有上传的照片二维数组记录对应的照片选择器上传成功以后返回的地址*/
@property(nonatomic,strong)NSMutableArray<NSMutableArray*> *allUrlArray;

/**
 判断照片上传对应选择器 删除 添加操作

 @param photos <#photos description#>
 @param photoView <#photoView description#>
 */
-(void)upLoadPhotos:(NSArray<HXPhotoModel *> *)photos withPhotoView:(UIView*)photoView;
@end
