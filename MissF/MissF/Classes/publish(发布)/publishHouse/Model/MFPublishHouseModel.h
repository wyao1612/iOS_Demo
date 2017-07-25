//
//  MFPublishHouseModel.h
//  MissF
//
//  Created by wyao on 2017/7/24.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class houseRoomModel;
@interface MFPublishHouseModel : NSObject
/** id*/
@property(nonatomic,copy) NSString  *ID;
/** 标题*/
@property(nonatomic,copy) NSString  *title;
/** 描述补充*/
@property(nonatomic,copy) NSString  *des;
/** 用户uid*/
@property(nonatomic,copy) NSString  *uid;
/** 地址*/
@property(nonatomic,copy) NSString  *address;
/** 封面照片数组*/
@property(nonatomic,strong) NSArray  *images;
/** 房屋价格*/
@property(nonatomic,copy) NSString  *money;
/** 最小价格*/
@property(nonatomic,copy) NSString  *minMoney;
/** 最大价格*/
@property(nonatomic,copy) NSString  *maxMoney;
/** 房间数*/
@property(nonatomic,copy) NSString  *room;
/** 厅*/
@property(nonatomic,copy) NSString  *hall;
/** 卫生间*/
@property(nonatomic,copy) NSString  *toilet;
/** 总楼层*/
@property(nonatomic,copy) NSString  *floor;
/** 当前楼层*/
@property(nonatomic,copy) NSString  *currentFloor;
/** 门牌号*/
@property(nonatomic,copy) NSString  *roomNumber;
/** 公共设备*/
@property(nonatomic,copy) NSString  *facilities;
/** 室友要求*/
@property(nonatomic,copy) NSString  *roommateRequires;
/** 更新时间*/
@property(nonatomic,copy) NSString  *updated;
/** 创建时间*/
@property(nonatomic,copy) NSString  *created;
/** 经度*/
@property(nonatomic,assign) CGFloat  longitude;
/** 纬度*/
@property(nonatomic,assign) CGFloat  latitude;
/** 是否是房东*/
@property(nonatomic,copy) NSString  *houseOwner;
/** 押*/
@property(nonatomic,copy) NSString  *wager;
/** 付*/
@property(nonatomic,copy) NSString  *pungle;
/** 房间对象*/
@property(nonatomic,strong) NSArray<houseRoomModel*>  *houseRoom;
@end


@interface houseRoomModel : NSObject
/** id*/
@property(nonatomic,copy) NSString  *ID;
/** 用户uid*/
@property(nonatomic,copy) NSString  *uid;
/** 房屋名称*/
@property(nonatomic,copy) NSString  *name;
/** 房屋Id*/
@property(nonatomic,copy) NSString  *userHouseId;
/** 房屋类型 主卧 次卧*/
@property(nonatomic,copy) NSString  *roomType;
/** 金额*/
@property(nonatomic,copy) NSString  *price;
/** orientate*/
@property(nonatomic,copy) NSString  *orientate;
/** 封面照片数组*/
@property(nonatomic,strong) NSArray  *images;
@end


